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
FactoryBot.define do
  factory :shift do
    user
    start_at { Time.zone.now }
    end_at { 1.second.from_now }
  end
end
