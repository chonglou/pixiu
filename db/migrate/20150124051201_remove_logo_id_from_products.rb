class RemoveLogoIdFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :logo
  end
end
