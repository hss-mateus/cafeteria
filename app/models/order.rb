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

  attribute :session

  after_update_commit :broadcast_replace_later

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
      transitions from: :scratch, to: :payment_started, after: :create_session
      transitions from: :scratch, to: :scratch
    end

    event :handle_payment_result do
      transitions from: :payment_started, to: :payment_succeeded, if: ->(result) { result == "success" }
      transitions from: :payment_started, to: :scratch
    end

    event :serve do
      transitions from: :payment_succeeded, to: :served
    end
  end

  def calculate_values!
    items.each(&:calculate_values!)

    update!(
      gross_value_cents: items.sum(:liquid_value_cents),
      discount_cents: items.sum(:discount_cents),
      liquid_value_cents: items.sum(:liquid_value_cents)
    )
  end

  def payment_token
    Digest::SHA256.hexdigest([id, user_id, created_at].join)
  end

  private

  def create_session
    self.session = Stripe::Checkout::Session.create({
      mode: "payment",
      success_url: current_order_payment_result_url(status: :success, token: payment_token),
      cancel_url: current_order_payment_result_url(status: :failed, token: payment_token),
      line_items: items.map { |item|
        {
          quantity: item.quantity,
          price_data: {
            currency: "BRL",
            unit_amount: item.unit_value_cents,
            product_data: { name: item.product.name }
          }
        }
      }
    })
  end
end
