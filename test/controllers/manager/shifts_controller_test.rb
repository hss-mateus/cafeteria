require "test_helper"

class Manager::ShiftsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user
    @user = create(:user, role: :employee)
    @shift = create(:shift)
  end

  test "should get index" do
    get manager_shifts_path
    assert_response :success
  end

  test "should get new" do
    get new_manager_user_shift_path(@user, shift: { start_at: Time.zone.now })

    assert_response :success
  end

  test "should create shift when parameters are valid" do
    assert_difference "@user.shifts.count" do
      post manager_user_shifts_path(@user), params: { shift: @shift.attributes, format: :turbo_stream }
    end

    assert_response :success
  end

  test "should not create shift when parameters are invalid" do
    assert_no_difference "Shift.count" do
      post manager_user_shifts_path(@user), params: {
        shift: { start_at: Time.zone.now, end_at: 20.hours.ago }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_manager_shift_path(@shift)
    assert_response :success
  end

  test "should update shift when parameters are valid" do
    assert_changes ->{ @shift.reload.values_at(:start_at, :end_at) } do
      patch manager_shift_path(@shift), params: {
        shift: { start_at: 98.hours.from_now, end_at: 99.hours.from_now },
        format: [:html, :turbo_stream]
      }
    end

    assert_response :success
  end

  test "should not update shift when parameters are invalid" do
    assert_no_changes ->{ @shift.reload.values_at(:start_at, :end_at) } do
      patch manager_shift_path(@shift), params: {
        shift: { start_at: Time.zone.now, end_at: 20.hours.ago },
        format: [:html, :turbo_stream]
      }
    end

    assert_response :unprocessable_entity
  end

  test "should destroy shift" do
    assert_difference "Shift.count", -1 do
      delete manager_shift_path(@shift, format: :turbo_stream)
    end

    assert_response :success
  end
end
