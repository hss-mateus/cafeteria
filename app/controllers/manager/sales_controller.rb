class Manager::SalesController < ApplicationController
  before_action :set_sale, only: [:edit, :update, :destroy]

  def index
    @sales = Sale.order(id: :desc)
  end

  def new
    @sale = Sale.new
  end

  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      redirect_to [:manager, :sales], notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @sale.update(sale_params)
      redirect_to [:manager, :sales], notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sale.destroy!

    redirect_to [:manager, :sales], notice: t(".success")
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:product_id, :discount_cents, :valid_until)
  end
end
