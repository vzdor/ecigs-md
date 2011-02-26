class ChangeProductsPriceScale < ActiveRecord::Migration
  def self.up
    change_column :products, :price, :decimal, :precision => 10, :scale => 2
  end

  def self.down
  end
end
