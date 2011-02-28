class CreateOrderAddresses < ActiveRecord::Migration
  def self.up
    create_table :order_addresses do |t|
      t.integer :order_id, :null => false
      t.integer :user_id, :null => false
      t.string :city
      t.string :street
      t.string :phone_number
      t.string :phone_number2

      t.timestamps
    end
  end

  def self.down
    drop_table :order_addresses
  end
end
