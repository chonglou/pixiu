class CreateVisitCounters < ActiveRecord::Migration
  def change
    create_table :visit_counters do |t|
      t.integer :flag, null:false, limit:2
      t.integer :key, null:false
      t.integer :count, null:false, default:0
    end
  end
end
