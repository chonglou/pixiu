class AddLogoToSample < ActiveRecord::Migration
  def change
    change_table :samples do |t|
      t.boolean :logo, null:false, default:false
    end
  end
end
