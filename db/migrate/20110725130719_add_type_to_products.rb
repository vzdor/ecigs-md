class AddTypeToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :type, :string, :default => Product.to_s
  end

  def self.down
    remove_column :products, :type
  end
end
