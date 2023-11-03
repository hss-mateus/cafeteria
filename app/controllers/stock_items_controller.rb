class StockItemsController < ApplicationController
  before_action :require_manager
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @items = StockItem.order(:name)
  end

  def new
    @item = StockItem.new
  end

  def create
    @item = StockItem.new(item_params)

    if @item.save
      redirect_to :stock_items, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to :stock_items, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy

    redirect_to :stock_items, notice: t(".success")
  end

  private

  def set_item
    @item = StockItem.find(params[:id])
  end

  def item_params
    params.require(:stock_item).permit(
      :name,
      :quantity,
      :unit
    )
  end
end
