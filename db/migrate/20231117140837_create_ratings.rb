class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :value, null: false

      t.timestamps
    end

    add_index :ratings, [:user_id, :product_id], unique: true
  end
end
