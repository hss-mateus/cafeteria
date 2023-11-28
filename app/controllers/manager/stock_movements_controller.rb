class Manager::StockMovementsController < Manager::ApplicationController
  before_action :set_movemnt, only: [:edit, :update, :destroy]

  def index
    @movements = StockMovement.order(created_at: :desc)
  end

  def new
    @movement = StockMovement.new
  end

  def create
    @movement = StockMovement.new(movement_params)

    if @movement.save
      redirect_to [:manager, :stock_movements], notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @movement.update(movement_params)
      redirect_to [:manager, :stock_movements], notice: t(".success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movement.destroy

    redirect_to [:manager, :stock_movements], notice: t(".success")
  end

  private

  def set_movemnt
    @movement = StockMovement.find(params[:id])
  end

  def movement_params
    params.require(:stock_movement).permit(
      :item_id,
      :category,
      :performed_at,
      :quantity,
      :unit_cost_cents
    )
  end
end
