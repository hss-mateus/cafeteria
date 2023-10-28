class OrderItemsController < ApplicationController
  before_action :set_order

  def create
    order_item = @order
      .order_items
      .create_or_find_by(item_id: params[:item_id])

    order_item.increment(:quantity).save unless order_item.saved_changes?

    @order.calculate_total_value!

    redirect_to :order
  end

  def destroy
    order_item = @order.order_items.find(params[:id])
    order_item.decrement(:quantity).save
    order_item.destroy if order_item.quantity.zero?

    @order.calculate_total_value!

    redirect_to :order
  end

  def set_order
    @order = current_user.orders.scratch.first_or_create
  end
end
