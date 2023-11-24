class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.date :valid_until, null: false
      t.references :product, null: false, foreign_key: true
      t.integer :discount_cents, null: false

      t.timestamps
    end
  end
end
