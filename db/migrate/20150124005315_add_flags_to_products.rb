class AddFlagsToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.boolean :hot, null:false, default:false
      t.boolean :latest, null:false, default:false
      t.integer :logo_id
    end
    change_table :users do |t|
      t.integer :logo_id
    end
    remove_column :contacts, :logo
  end
end
