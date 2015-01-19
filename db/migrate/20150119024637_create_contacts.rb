class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id, null: false
      t.string :qq, limit: 16
      t.string :wechat, limit: 32
      t.string :logo
      t.string :fax, limit: 16
      t.string :phone, limit: 16
      t.string :email, limit: 32
      t.string :skype, limit: 32
      t.string :address
      t.text :details
      t.timestamps null: false
    end
  end
end
