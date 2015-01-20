class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name, null:false, limit:32
      t.string :lang, null:false, default:ENV['PIXIU_LOCALE'], limit:5
      t.string :title, null:false, limit:64
      t.string :summary, null:false
      t.text :body, null:false
      t.timestamps null: false
    end
    add_index :documents, [:name, :lang], unique: true
  end
end
