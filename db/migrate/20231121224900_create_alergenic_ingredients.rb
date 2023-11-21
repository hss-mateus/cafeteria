class CreateAlergenicIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :alergenic_ingredients do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
