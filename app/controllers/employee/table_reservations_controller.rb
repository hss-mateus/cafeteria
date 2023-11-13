class Employee::TableReservationsController < Employee::ApplicationController
  before_action :set_reservation, only: [:edit, :update, :destroy]

  def index
    @reservation_groups = TableReservation.where(date: Time.zone.now..).group_by { _1.date.to_date }
  end

  def edit; end

  def update
    if @reservation.update(reservation_params)
      redirect_to [:employee, :table_reservations], notice: t(".success")
    else
      redirect_to [:edit, :employee, @reservation], alert: @reservation.errors.full_messages.to_sentence
    end
  end

  def destroy
    @reservation.destroy!

    redirect_to [:employee, :table_reservations], notice: t(".success")
  end

  private

  def set_reservation
    @reservation = TableReservation.find(params[:id])
  end

  def reservation_params
    params.require(:table_reservation).permit(:date, :hour_index, :table_number)
  end
end
