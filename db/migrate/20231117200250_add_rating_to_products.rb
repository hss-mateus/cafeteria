class AddRatingToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :rating, :float, null: false, default: 0
  end
end
