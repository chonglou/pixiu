class CreateProductTags < ActiveRecord::Migration
  def change
    create_table :product_tags, id: false do |t|
      t.string :product_uid, null: false, limit:36
      t.integer :tag_id, null: false
    end
    add_index :product_tags, :product_uid
  end
end
