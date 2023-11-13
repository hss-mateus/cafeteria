require "test_helper"

class Employee::TableReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user(create(:user, role: :employee))

    @reservation = create(:table_reservation)
  end

  test "should get index" do
    get employee_table_reservations_path

    assert_response :success
  end

  test "should get edit" do
    get edit_employee_table_reservation_path(@reservation)

    assert_response :success
  end

  test "should update table reservation when params are valid" do
    assert_changes "@reservation.reload.attributes" do
      patch employee_table_reservation_path(@reservation), params: {
        table_reservation: {
          date: 3.days.from_now,
          hour_index: 0,
          table_number: TableReservation::AVAILABLE_TABLES.first
        }
      }
    end

    assert_redirected_to employee_table_reservations_path
  end

  test "should not update table reservation when params are invalid" do
    assert_no_changes "@reservation.reload.attributes" do
      patch employee_table_reservation_path(@reservation), params: {
        table_reservation: {
          date: 1.day.ago,
          hour_index: -1,
          table_number: -1
        }
      }
    end

    assert_redirected_to edit_employee_table_reservation_path(@reservation)
  end

  test "should destroy table reservation" do
    assert_difference "TableReservation.count", -1 do
      delete employee_table_reservation_path(@reservation)
    end

    assert_redirected_to employee_table_reservations_path
  end
end
