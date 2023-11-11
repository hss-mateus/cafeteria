class AddTimestampsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :payment_started_at, :datetime
    add_column :orders, :payment_succeeded_at, :datetime
    add_column :orders, :served_at, :datetime
  end
end
