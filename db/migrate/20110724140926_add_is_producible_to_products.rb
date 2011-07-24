class AddIsProducibleToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_producible, :boolean, :default => false
  end

  def self.down
    remove_column :products, :is_producible
  end
end
