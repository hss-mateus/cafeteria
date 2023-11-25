# == Schema Information
#
# Table name: orders
#
#  id                   :integer          not null, primary key
#  discount_cents       :integer          default(0), not null
#  gross_value_cents    :integer          default(0), not null
#  liquid_value_cents   :integer          default(0), not null
#  observation          :text
#  payment_started_at   :datetime
#  payment_succeeded_at :datetime
#  served_at            :datetime
#  status               :integer          default("scratch"), not null
#  used_loyalty_points  :integer          default(0), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :integer          not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Order < ApplicationRecord
  include AASM
  include Rails.application.routes.url_helpers

  belongs_to :user

  has_many :items, dependent: :destroy, class_name: "OrderItem"
  has_many :products, through: :items

  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true

  validates :used_loyalty_points, numericality: { in: (0..) }

  attribute :session

  after_update_commit :broadcast_replace_later, unless: :scratch?

  enum status: {
    scratch: 0,
    payment_started: 1,
    payment_succeeded: 2,
    served: 4
  }

  scope :confirmed, -> { where(status: [:payment_succeeded, :served]) }

  aasm column: :status, enum: true, requires_lock: true, timestamps: true do
    state :scratch, initial: true
    state :payment_started,
          :payment_succeeded,
          :served

    event :start_payment do
      transitions from: :scratch, to: :payment_started, after: [:create_session, :discount_loyalty_points]
      transitions from: :scratch, to: :scratch
    end

    event :handle_payment_result do
      transitions from: :payment_started,
                  to: :payment_succeeded,
                  if: ->(result) { result == "success" },
                  after: :reward_user
      transitions from: :payment_started, to: :scratch, after: :restore_loyalty_points
    end

    event :serve do
      transitions from: :payment_succeeded, to: :served
    end
  end

  def discount?
    (discount_cents + used_loyalty_points).positive?
  end

  def calculate_values!
    items.each(&:calculate_values!)

    self.used_loyalty_points = [used_loyalty_points, user.loyalty_points].min

    update!(
      gross_value_cents: items.sum(:gross_value_cents),
      discount_cents: items.sum(:discount_cents) + used_loyalty_points,
      liquid_value_cents: items.sum(:liquid_value_cents) - used_loyalty_points
    )
  end

  def maximum_points
    [(liquid_value_cents + used_loyalty_points), user.loyalty_points].min
  end

  def payment_token
    Digest::SHA256.hexdigest([id, user_id, created_at].join)
  end

  def reward
    liquid_value_cents / 100 * 2
  end

  private

  def create_session
    remaining_points = used_loyalty_points

    self.session = Stripe::Checkout::Session.create({
      mode: "payment",
      success_url: order_payment_result_url(self, status: :success, token: payment_token),
      cancel_url: order_payment_result_url(self, status: :failed, token: payment_token),
      line_items: items.map { |item|
        used_points = [remaining_points, item.liquid_value_cents].min
        remaining_points -= used_points

        {
          quantity: 1,
          price_data: {
            currency: "BRL",
            unit_amount: item.liquid_value_cents - used_points,
            product_data: { name: item.product.name }
          }
        }
      }
    })
  end

  def discount_loyalty_points
    user.decrement!(:loyalty_points, used_loyalty_points)
  end

  def restore_loyalty_points
    user.transaction do
      user.increment!(:loyalty_points, used_loyalty_points)
      decrement!(:used_loyalty_points, 0)
    end
  end

  def reward_user
    user.increment!(:loyalty_points, reward)
  end
end
