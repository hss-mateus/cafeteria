class Manager::CategoriesController < Manager::ApplicationController
  before_action :require_category, only: [:edit, :update, :destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    render :new, status: :unprocessable_entity unless @category.save
  end

  def edit; end

  def update
    render :edit, status: :unprocessable_entity unless @category.update(category_params)
  end

  def destroy
    @category.destroy
  end

  private

  def require_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
