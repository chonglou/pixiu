class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :lang, null:false, default:ENV['PIXIU_LOCALE'], limit:5
      t.string :title, null:false
      t.text :body, null:false
      t.timestamps null: false
    end
    add_index :documents, :title
  end
end
