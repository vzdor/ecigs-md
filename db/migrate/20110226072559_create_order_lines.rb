class CreateOrderLines < ActiveRecord::Migration
  def self.up
    create_table :order_lines do |t|
      t.integer :order_id, :null => false
      t.integer :product_id, :null => false
      t.decimal :price
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :order_lines
  end
end
