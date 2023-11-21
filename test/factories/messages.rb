# == Schema Information
#
# Table name: messages
#
#  id             :integer          not null, primary key
#  content        :text             not null
#  recipient_type :string           not null
#  status         :integer          default("unread"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  recipient_id   :integer          not null
#  sender_id      :integer          not null
#
# Indexes
#
#  index_messages_on_recipient  (recipient_type,recipient_id)
#  index_messages_on_sender_id  (sender_id)
#
# Foreign Keys
#
#  sender_id  (sender_id => users.id)
#
FactoryBot.define do
  factory :message do
    content { "Test message" }
    sender factory: :user
    recipient factory: :user
  end
end
