class AddUidToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :uid, null: false, limit:36
    end
    add_index :users, :uid, unique: true
  end
end
