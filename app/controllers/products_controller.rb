class ProductsController < ApplicationController
  skip_before_action :require_login, only: [:show]
  before_action :require_manager, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_product, only: [:show, :edit, :update, :destroy]

  def show; end

  def new
    @product = Product.new(product_params)
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to :categories, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to :categories, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    redirect_to :categories, notice: t(".success")
  end

  private

  def require_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.fetch(:product, {}).permit(
      :category_id,
      :name,
      :price_cents,
      :description,
      :picture,
      alergenic_ingredients_attributes: [
        :id,
        :_destroy,
        :name
      ]
    )
  end
end
