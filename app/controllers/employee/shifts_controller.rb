class Employee::ShiftsController < Employee::ApplicationController
  def index
    params[:q] ||= {}
    params[:q].reverse_merge!(
      start_at_gteq: Time.zone.today.to_date.iso8601,
      end_at_lteq: 6.days.from_now.to_date.iso8601
    )

    @start_at = Date.parse(params.dig(:q, :start_at_gteq))
    @end_at = Date.parse(params.dig(:q, :end_at_lteq))

    @q = current_user.shifts.ransack(params[:q])
    @shifts = @q.result.index_by { _1.start_at.to_date }
  end
end
