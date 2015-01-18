class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
      t.integer :flag, null:false, limit:2
      t.string :lang, null:false, limit:5
      t.string :uid, null:false, limit:36
      t.integer :tid, null:false
    end
    add_index :locales, :lang
    add_index :locales, :uid
  end
end
