class Employee::UsersController < Employee::ApplicationController
  def index
    @users = User
      .where(role: [:employee, :manager])
      .excluding(current_user)
      .order(:name)

    @unread_chats = current_user.received_messages.unread.distinct.pluck(:sender_id)
  end
end
