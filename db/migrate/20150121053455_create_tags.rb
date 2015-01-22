class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false, limit: 32
      t.string :lang, null: false, default: ENV['PIXIU_LOCALE'], limit: 5
      t.integer :parent_id
      t.integer :flag, null:false
      t.string :uid, null:false, limit:36
      t.timestamps null: false
    end
    add_index :tags, :uid, unique: true
    add_index :tags, :name
    add_index :tags, :lang
  end
end
