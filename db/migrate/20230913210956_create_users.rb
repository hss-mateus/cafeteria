class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.string :crypted_password, default: nil
      t.string :salt, default: nil

      t.string :remember_me_token, default: nil
      t.datetime :remember_me_token_expires_at, default: nil

      t.string :activation_state, default: nil
      t.string :activation_token, default: nil
      t.datetime :activation_token_expires_at, default: nil

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :remember_me_token
    add_index :users, :activation_token
  end
end
