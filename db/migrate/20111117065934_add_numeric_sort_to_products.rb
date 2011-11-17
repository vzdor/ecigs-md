class AddNumericSortToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :numeric_sort, :boolean, :default => false
  end

  def self.down
    remove_column :products, :numeric_sort
  end
end
