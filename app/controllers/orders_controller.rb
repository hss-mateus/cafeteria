class OrdersController < ApplicationController
  before_action :set_order

  def show; end

  def update; end

  private

  def set_order
    @order = current_user.orders.scratch.first_or_create
  end
end
