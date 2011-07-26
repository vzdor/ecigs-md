class AddOptionalToOrderLines < ActiveRecord::Migration
  def self.up
    add_column :order_lines, :optional, :text
  end

  def self.down
    remove_column :order_lines, :optional
  end
end
