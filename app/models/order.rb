# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  observation       :text
#  status            :integer          default("scratch"), not null
#  total_value_cents :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer          not null
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

  belongs_to :user

  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  enum status: {
    scratch: 0,
    payment_started: 1,
    payment_succeeded: 2,
    payment_failed: 3,
    served: 4
  }

  aasm column: :status, enum: true, requires_lock: true do
    state :scratch, initial: true
    state :payment_started,
          :payment_succeeded,
          :payment_failed,
          :served

    event :start_payment do
      transitions from: [:scratch, :payment_failed], to: :payment_started
      transitions from: [:scratch, :payment_failed], to: :payment_failed
    end

    event :handle_payment_result do
      transitions from: :payment_started, to: :payment_succeeded
      transitions from: :payment_started, to: :payment_failed
    end
  end

  def calculate_total_value!
    update!(total_value_cents: order_items.sum(:value_cents))
  end
end
