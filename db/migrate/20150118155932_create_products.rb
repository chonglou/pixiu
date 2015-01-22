class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :lang, null:false, default:ENV['PIXIU_LOCALE'], limit:5
      t.string :uid, null:false, limit:36
      t.string :name, null:false
      t.string :logo
      t.string :summary, null:false
      t.text :details, null:false
      t.integer :status, null:false, default:0
      t.timestamps null:false
    end
    add_index :products, :uid, unique: true
    add_index :products, :lang
  end
end
