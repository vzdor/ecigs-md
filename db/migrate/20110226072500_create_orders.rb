class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id, :null => false
      t.datetime :shipped_on
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
