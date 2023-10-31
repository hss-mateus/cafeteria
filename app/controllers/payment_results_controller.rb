class PaymentResultsController < ApplicationController
  def show
    return if (@order = current_user.orders.payment_started.sole) &&
              params[:token] == @order.payment_token &&
              @order.handle_payment_result!(params[:status]) &&
              @order.payment_succeeded?

    @order.scratch!
    redirect_to :order, alert: t(".failure")
  end
end
