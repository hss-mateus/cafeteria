class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false, index: { unique: true }
      t.integer :price_cents, null: false

      t.timestamps
    end
  end
end
