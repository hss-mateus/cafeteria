class Manager::ShiftsController < Manager::ApplicationController
  before_action :set_user, only: [:new, :create]
  before_action :set_shift, only: [:edit, :update, :destroy]

  def index
    params[:q] ||= {}
    params[:q].reverse_merge!(
      start_at_gteq: Time.zone.today.to_date.iso8601,
      end_at_lteq: 6.days.from_now.to_date.iso8601
    )

    @start_at = Date.parse(params.dig(:q, :start_at_gteq))
    @end_at = Date.parse(params.dig(:q, :end_at_lteq))

    @q = Shift.ransack(params[:q])
    @shifts = @q.result.index_by { [_1.user, _1.start_at.to_date] }
  end

  def new
    @shift = @user.shifts.new(shift_params)
  end

  def create
    @shift = @user.shifts.new(shift_params)

    render :new, status: :unprocessable_entity unless @shift.save
  end

  def edit; end

  def update
    render :edit, status: :unprocessable_entity unless @shift.update(shift_params)
  end

  def destroy
    @shift.destroy!
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:start_at, :end_at)
  end
end
