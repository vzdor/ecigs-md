class ChangeOrderLinesPriceScale < ActiveRecord::Migration
  def self.up
    change_column :order_lines, :price, :decimal, :precision => 10, :scale => 2
  end

  def self.down
  end
end
