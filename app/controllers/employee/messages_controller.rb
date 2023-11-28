class Employee::MessagesController < Employee::ApplicationController
  before_action :set_user

  def index
    received_messages = current_user.received_messages.where(sender: @user)
    sent_messages = current_user.sent_messages.where(recipient: @user)
    scope = received_messages.or(sent_messages).order(id: :desc)

    if (last = params[:last])
      scope = scope.where(id: ..last)
    end

    received_messages.update!(status: :read)

    @pagy, @messages = pagy_countless(scope, items: 40, countless_minimal: true)
  end

  def create
    current_user.sent_messages.create(message_params.merge(recipient: @user))

    render turbo_stream: [
      turbo_stream.invoke(:reset, selector: "#message-form"),
      turbo_stream.invoke(:focus, selector: "#message_content")
    ]
  end

  private

  def set_user
    @user = User
      .where(role: [:employee, :manager])
      .excluding(current_user)
      .find(params[:user_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
