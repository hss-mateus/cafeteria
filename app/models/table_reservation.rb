# == Schema Information
#
# Table name: table_reservations
#
#  id           :integer          not null, primary key
#  date         :datetime         not null
#  table_number :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_table_reservations_on_date_and_table_number  (date,table_number) UNIQUE
#  index_table_reservations_on_user_id                (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class TableReservation < ApplicationRecord
  belongs_to :user

  AVAILABLE_TABLES = (1..10)

  attribute :hour_index, :integer

  validates :table_number, inclusion: { in: AVAILABLE_TABLES }, uniqueness: { scope: :date }
  validates :date, presence: true
  validate :permitted_time
  validate :date_in_future, on: :create

  def hour_index=(_)
    super

    return if date.blank? || hour_index.blank?

    scheduled_hour = self.class.permitted_hours[hour_index]
    self.date = date.at_beginning_of_day + scheduled_hour.hours
  end

  def self.permitted_hours
    first_hour = 6
    last_hour = 22
    max_duration = 2

    (first_hour..last_hour).step(max_duration).to_a
  end

  def self.week_range_reservation_groups
    week_range = (Time.zone.today..6.days.from_now.at_beginning_of_day)
    reservation_groups = TableReservation
      .where(date: Time.zone.today..6.days.from_now.at_end_of_day)
      .group_by { [_1.date.to_date, _1.date.hour] }
      .tap { _1.default = [] }

    [week_range, reservation_groups]
  end

  def self.available_tables(groups, date, hour)
    reservations = groups[[date, hour]]

    TableReservation::AVAILABLE_TABLES.excluding(reservations.pluck(:table_number)).presence
  end

  private

  def permitted_time
    return if date.blank? || (date.min.zero? && date.hour.in?(self.class.permitted_hours))

    errors.add(:date)
  end

  def date_in_future
    return if date.blank? || date.future?

    errors.add(:date, :date_in_future)
  end
end
