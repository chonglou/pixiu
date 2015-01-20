class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :user_id, null:false
      t.string :title, null:false
      t.string :content_type, null:false
      t.string :ext, limit:5, null:false
      t.timestamps null: false
    end
    add_index :attachments, :title
    add_index :attachments, :ext
    add_index :attachments, :content_type
  end
end
