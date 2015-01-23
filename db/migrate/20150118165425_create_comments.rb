class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :project_uid, null:false, limit:32
      t.string :uid, null:false, limit:32
      t.text :content, null:false
      t.integer :comment_id
      t.integer :order_id, null:false
      t.integer :user_id, null:false
      t.integer :star, null:false
      t.timestamps null:false
    end
    add_index :comments, :project_uid
    add_index :comments, :uid
  end
end
