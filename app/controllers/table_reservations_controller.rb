class TableReservationsController < ApplicationController
  def index
    @reservations = current_user.table_reservations.order(id: :desc)
  end

  def new
    @reservation = TableReservation.new
  end

  def create
    @reservation = current_user.table_reservations.new(reservation_params)

    if @reservation.save
      redirect_to :table_reservations, notice: t(".success")
    else
      redirect_to [:new, :table_reservation], alert: @reservation.errors.full_messages.to_sentence
    end
  end

  def destroy
    @reservation = current_user.table_reservations.find(params[:id]).destroy!
    redirect_to :table_reservations, notice: t(".success"), status: :see_other
  end

  private

  def reservation_params
    params.require(:table_reservation).permit(:date, :hour_index, :table_number)
  end
end
