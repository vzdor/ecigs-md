class AddIsPrimaryToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_primary, :boolean, :default => false
  end

  def self.down
    remove_column :products, :is_primary
  end
end
