class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id, null: false
      t.string :uid, limit: 36, null: false
      t.integer :status, null: false, default: 0
      t.timestamps null: false
    end

    add_index :orders, :uid, unique: true

    create_table :orders_products, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :order, index: true
    end
  end
end
