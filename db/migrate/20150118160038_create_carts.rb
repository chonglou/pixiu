class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.string :token, limit:36, null:false
      t.timestamps null: false
    end
    add_index :carts, :token

    create_table :carts_products, id:false do |t|
      t.belongs_to :product, index:true
      t.belongs_to :cart, index:true
    end
  end
end
