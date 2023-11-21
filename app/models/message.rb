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
class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, polymorphic: true

  enum status: {
    unread: 0,
    read: 1
  }

  validates :content, presence: true

  after_create_commit do
    broadcast_action_later_to(
      channel,
      action: :before,
      target: :bottom,
      locals: { focus: true }
    )

    broadcast_invoke_later_to(
      [recipient, :chats],
      :dispatch_event,
      args: ["new-message"],
      selector: "#user_#{sender_id}"
    )
  end

  def self.channel(sender, recipient)
    [sender.id, recipient.class, recipient.id, :chat].map(&:to_s).sort
  end

  def channel
    self.class.channel(sender, recipient)
  end
end
