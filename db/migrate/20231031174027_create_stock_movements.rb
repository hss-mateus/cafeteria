class CreateStockMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_movements do |t|
      t.references :item, foreign_key: { to_table: :stock_items }
      t.string :name, null: false
      t.integer :category, null: false, default: 0
      t.float :quantity, null: false
      t.string :unit, null: false
      t.integer :unit_cost_cents
      t.datetime :performed_at, null: false, default: ->{ "CURRENT_TIMESTAMP" }

      t.timestamps
    end
  end
end
