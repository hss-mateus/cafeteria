class AddSessionUrlToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :checkout_url, :string
  end
end
