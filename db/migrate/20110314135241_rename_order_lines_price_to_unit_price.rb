class RenameOrderLinesPriceToUnitPrice < ActiveRecord::Migration
  def self.up
    rename_column :order_lines, :price, :unit_price
  end

  def self.down
    rename_column :order_lines, :unit_price, :price
  end
end
