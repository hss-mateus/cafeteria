require "test_helper"

class TableReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = login_user
    @reservation = create(:table_reservation, user: @user)
  end

  def fill_date(date)
    TableReservation::AVAILABLE_TABLES.each { create(:table_reservation, date:, table_number: _1) }
  end

  test "should get index" do
    get table_reservations_path

    assert_response :success
  end

  test "should get new" do
    fill_date(Time.zone.tomorrow.at_beginning_of_day + 10.hours)

    travel_to(Time.zone.today.at_beginning_of_day + 12.hours) do
      get new_table_reservation_path
    end

    assert_response :success
  end

  test "should create table_reservation when params are valid" do
    assert_difference("TableReservation.count") do
      post table_reservations_path, params: {
        table_reservation: {
          date: Time.zone.tomorrow,
          hour_index: 0,
          table_number: TableReservation::AVAILABLE_TABLES.first
        }
      }
    end

    assert_redirected_to table_reservations_path
  end

  test "should not create table_reservation when params are invalid" do
    assert_no_difference("TableReservation.count") do
      post table_reservations_path, params: {
        table_reservation: {
          date: 1.day.ago,
          table_number: -1
        }
      }
    end

    assert_redirected_to new_table_reservation_path
  end

  test "should destroy table_reservation" do
    assert_difference("@user.table_reservations.count", -1) do
      delete table_reservation_path(@reservation)
    end

    assert_redirected_to table_reservations_path
  end
end
