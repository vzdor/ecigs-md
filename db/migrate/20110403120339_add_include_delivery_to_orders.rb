class AddIncludeDeliveryToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :include_delivery, :boolean, :default => 1
  end

  def self.down
    remove_column :orders, :include_delivery
  end
end
