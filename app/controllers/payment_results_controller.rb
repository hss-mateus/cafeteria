class PaymentResultsController < ApplicationController
  before_action :set_order

  def show
    if params[:token] == @order.payment_token &&
       @order.handle_payment_result!(params[:status]) &&
       @order.payment_succeeded?
      redirect_to @order, notice: t(".success", reward: @order.reward)
    else
      redirect_to @order, alert: t(".failure")
    end
  end

  private

  def set_order
    @order = current_user.orders.payment_started.find(params[:order_id])
  end
end
