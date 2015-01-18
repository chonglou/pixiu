class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :lang, null:false, default:ENV['PIXIU_LOCALE'], limit:5
      t.string :content, null:false
      t.timestamps null: false
    end
    add_index :notices, :lang
  end
end
