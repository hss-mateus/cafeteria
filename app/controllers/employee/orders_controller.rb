class Employee::OrdersController < Employee::ApplicationController
  before_action :set_order, only: [:show, :update]

  def index
    @pending_orders = Order.payment_succeeded.order(id: :desc)
    @pagy, @completed_orders = pagy(Order.served.order(id: :desc))
  end

  def show; end

  def update
    @order.serve!

    redirect_to [:employee, :orders], notice: t(".success")
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
