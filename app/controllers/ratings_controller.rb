class RatingsController < ApplicationController
  def create
    order = current_user.confirmed_orders.find(params[:order_id])
    product = order.products.find(params[:product_id])
    rating = current_user.ratings.create_with(rating_params).create_or_find_by(product:)

    rating.update!(rating_params) unless rating.saved_changes?

    redirect_to order
  end

  private

  def rating_params
    params.require(:rating).permit(:value)
  end
end
