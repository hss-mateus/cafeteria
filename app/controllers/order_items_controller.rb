class OrderItemsController < ApplicationController
  before_action :set_order

  def create
    item = @order
      .items
      .create_or_find_by(product_id: params[:product_id])

    item.increment(:quantity).save unless item.saved_changes?

    @order.calculate_values!

    redirect_to :current_order
  end

  def destroy
    item = @order.items.find(params[:id])
    item.decrement(:quantity).save
    item.destroy if item.quantity.zero?

    @order.calculate_values!

    redirect_to :current_order
  end

  def set_order
    @order = current_user.orders.scratch.first_or_create
  end
end
