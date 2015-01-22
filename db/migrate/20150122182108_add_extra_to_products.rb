class AddExtraToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.text :spec
      t.text :pack
      t.text :service
    end

  end
end
