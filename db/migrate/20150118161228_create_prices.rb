class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :product_id, null:false
      t.decimal :value, null:false, default:0.0
      t.integer :flag, null:false, default:0
      t.timestamp :created, null: false
    end
  end
end
