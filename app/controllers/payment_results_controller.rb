class PaymentResultsController < ApplicationController
  def show
    if (@order = current_user.orders.payment_started.sole) &&
       params[:token] == @order.payment_token &&
       @order.handle_payment_result!(params[:status]) &&
       @order.payment_succeeded?
      redirect_to @order, notice: t(".success")
    else
      redirect_to :current_order, alert: t(".failure")
    end
  end
end
