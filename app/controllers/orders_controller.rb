class OrdersController < ApplicationController
  before_action :set_order
  before_action :require_items, only: :update

  def show; end

  def update
    @order.start_payment!

    redirect_to @order.session.url, status: :see_other, allow_other_host: true
  end

  private

  def set_order
    @order = current_user.orders.scratch.first_or_create
  end

  def require_items
    return if @order.order_items.any?

    redirect_to :order, alert: t(".failure")
  end
end
