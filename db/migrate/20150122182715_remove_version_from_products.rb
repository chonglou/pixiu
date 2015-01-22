class RemoveVersionFromProducts < ActiveRecord::Migration
  def change
    create_table :products_tags, id:false do |t|
      t.belongs_to :product, index:true, null:false
      t.belongs_to :tag, index:true, null:false
    end
  end
end
