class RenameItemsToProducts < ActiveRecord::Migration[7.1]
  def change
    rename_table :items, :products
    rename_column :order_items, :item_id, :product_id
  end
end
