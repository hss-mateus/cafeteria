class RemoveActivationFromUsers < ActiveRecord::Migration[7.1]
  def change
    change_table :users do |t|
      t.remove :activation_state, type: :string
      t.remove :activation_token, type: :string, index: true
      t.remove :activation_token_expires_at, type: :datetime
    end
  end
end
