class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.integer :product_id, null:false
      t.integer :attachment_id, null:false
      t.string :title, null:false
      t.string :summary, limit:500
      t.timestamps null: false
    end
  end
end
