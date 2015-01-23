class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :product_id, null:false
      t.decimal :value, null:false, default:0.0, precision: 15, scale: 2
      t.integer :flag, null:false, default:0
      t.timestamps null: false
    end
  end
end
