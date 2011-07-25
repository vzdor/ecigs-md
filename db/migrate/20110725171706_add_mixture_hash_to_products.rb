class AddMixtureHashToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :mixture_hash, :string
    add_index :products, :mixture_hash, :unique => true
  end

  def self.down
    remove_column :products, :mixture_hash
  end
end
