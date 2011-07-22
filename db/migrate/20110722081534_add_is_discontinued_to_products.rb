class AddIsDiscontinuedToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_discontinued, :boolean, :default => false
  end

  def self.down
    remove_column :products, :is_discontinued
  end
end
