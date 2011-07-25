class AddIsMixtureToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :is_mixture, :boolean, :default => false
  end

  def self.down
    remove_column :products, :is_mixture
  end
end
