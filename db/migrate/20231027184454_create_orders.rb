class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.integer :total_value_cents, null: false, default: 0
      t.text :observation

      t.timestamps
    end

    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, foreign_key: true
      t.string :name, null: false
      t.integer :value_cents, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end

    add_index :order_items, [:order_id, :item_id], unique: true
  end
end
