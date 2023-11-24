class AddPartialValuesToOrder < ActiveRecord::Migration[7.1]
  def change
    change_table :orders do |t|
      t.rename :total_value_cents, :liquid_value_cents
      t.integer :gross_value_cents, null: false, default: 0
      t.integer :discount_cents, null: false, default: 0
    end

    change_table :order_items do |t|
      t.rename :value_cents, :liquid_value_cents
      t.integer :gross_value_cents, null: false, default: 0
      t.integer :discount_cents, null: false, default: 0
    end
  end
end
