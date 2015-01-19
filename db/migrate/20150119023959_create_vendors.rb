class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name, null:false
      t.text :details, null:false
      t.timestamps null: false
    end

    change_table :products do |t|
      t.integer :vendor_id, null:false
    end
  end
end
