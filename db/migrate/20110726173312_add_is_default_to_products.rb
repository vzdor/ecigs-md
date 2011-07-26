class AddIsDefaultToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_default, :boolean, :default => false
  end

  def self.down
    remove_column :products, :is_default
  end
end
