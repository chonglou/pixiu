class RemoveLogoUsers < ActiveRecord::Migration
  def change
    change_table :contacts do |t|
      t.integer :logo_id
    end
    remove_column :users, :logo_id
  end
end
