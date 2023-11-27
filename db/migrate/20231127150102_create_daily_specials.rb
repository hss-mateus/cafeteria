class CreateDailySpecials < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_specials do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :week_day, null: false
      t.integer :discount_cents, null: false

      t.timestamps
    end
  end
end
