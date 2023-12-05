# == Schema Information
#
# Table name: shifts
#
#  id         :integer          not null, primary key
#  end_at     :datetime         not null
#  start_at   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_shifts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Shift < ApplicationRecord
  belongs_to :user

  validates :start_at, :end_at, presence: true
  validate :start_before_end
  validate :duration_in_limit
  validate :unique_in_day

  def human_range
    [start_at, end_at].map { _1.strftime("%H:%M") }.join(" - ")
  end

  private

  def start_before_end
    return if start_at.blank? ||
              end_at.blank? ||
              start_at.before?(end_at)

    errors.add(:start_at, :date_order)
  end

  def duration_in_limit
    return if start_at.blank? ||
              end_at.blank? ||
              errors[:start_at].any? ||
              (end_at - start_at).seconds.in_hours < 12

    errors.add(:end_at, :duration)
  end

  def unique_in_day
    return if start_at.blank? ||
              errors[:start_at].any? ||
              errors[:end_at].any? ||
              self.class.where(user_id:, start_at: start_at.all_day).excluding(self).none?

    errors.add(:start_at, :unique_date)
  end
end
