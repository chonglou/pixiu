class AddUsernameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :first_name, null:false, limit:32
      t.string :last_name, null:false, limit:32
      t.string :middle_name, limit:32
      t.string :label, null:false, limit:32
    end
    add_index :users, [:first_name, :last_name, :middle_name]
    add_index :users, :label, unique: true
  end
end
