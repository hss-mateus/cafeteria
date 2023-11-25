class AddLoyaltyPointsFields < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :loyalty_points, :integer, null: false, default: 0
    add_column :orders, :used_loyalty_points, :integer, null: false, default: 0
  end
end
