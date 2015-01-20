class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :owner, null:false
      t.string :title, null:false
      t.string :name, limit:36, null:false
      t.string :ext, limit:5, null:false
      t.timestamps null: false
    end
    add_index :attachments, :name, unique: true
    add_index :attachments, :title
    add_index :attachments, :ext
  end
end
