class ProductsController < ApplicationController
  skip_before_action :require_login

  def show
    @product = Product.find(params[:id])
  end
end
