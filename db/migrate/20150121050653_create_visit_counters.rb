class CreateVisitCounters < ActiveRecord::Migration
  def change
    create_table :visit_counters do |t|
      t.integer :flag, null:false
      t.string :key, null:false
      t.integer :count, null:false, default:0
    end
    add_index :visit_counters, [:flag, :key], unique: true
  end
end
