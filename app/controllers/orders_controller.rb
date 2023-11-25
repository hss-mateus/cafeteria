class OrdersController < ApplicationController
  before_action :set_order, only: :update
  before_action :require_items, only: :update

  def index
    @orders = current_user.orders.where.not(status: :scratch).order(id: :desc)
  end

  def show
    if (id = params[:id])
      @order = current_user.orders.find(id)
    else
      @order = current_user.orders.scratch.first_or_create
      render :current_order
    end
  end

  def update
    if params.dig(:order, :start_payment)
      @order.update!(observation: params.dig(:order, :observation))
      @order.start_payment!

      redirect_to @order.checkout_url, status: :see_other, allow_other_host: true
    else
      @order.update(order_params) && @order.calculate_values!

      render :current_order, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = current_user.orders.where.not(status: :served).find(params[:id])
  end

  def require_items
    return if @order.items.any?

    redirect_to :current_order, alert: t(".failure")
  end

  def order_params
    params.require(:order).permit(:used_loyalty_points)
  end
end
