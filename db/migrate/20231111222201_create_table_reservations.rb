class CreateTableReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :table_reservations do |t|
      t.datetime :date, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :table_number, null: false

      t.timestamps
    end

    add_index :table_reservations, [:date, :table_number], unique: true
  end
end
