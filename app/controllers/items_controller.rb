class ItemsController < ApplicationController
  skip_before_action :require_login, only: [:show]
  before_action :require_manager, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_item, only: [:show, :edit, :update, :destroy]

  def show; end

  def new
    @item = Item.new(item_params)
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to :categories, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to :categories, notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy

    redirect_to :categories, notice: t(".success")
  end

  private

  def require_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.fetch(:item, {}).permit(
      :category_id,
      :name,
      :price_cents,
      :description,
      :picture
    )
  end
end
