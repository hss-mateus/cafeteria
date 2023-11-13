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
FactoryBot.define do
  factory :table_reservation do
    user
    date { rand(1..9999).days.from_now.at_beginning_of_day + TableReservation.permitted_hours.first.hours }
    table_number { rand(1..10) }
  end
end
