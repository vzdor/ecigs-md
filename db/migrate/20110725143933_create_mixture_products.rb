class CreateMixtureProducts < ActiveRecord::Migration
  def self.up
    create_table :mixture_products do |t|
      t.integer :mixture_id, :nil => false
      t.integer :product_id, :nil => false
    end
  end

  def self.down
    drop_table :mixture_products
  end
end
