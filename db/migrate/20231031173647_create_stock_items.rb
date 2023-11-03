class CreateStockItems < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_items do |t|
      t.string :name, null: false
      t.integer :unit, null: false
      t.float :quantity, null: false

      t.timestamps
    end
  end
end
