class AddUsernameToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.string :username
    end
    add_index :users, :username, unique: true
  end
end
