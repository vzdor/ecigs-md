class OrderLine < ActiveRecord::Base
  belongs_to :order

  belongs_to :product

  validates_numericality_of :quantity, :greater_than_or_equal_to => 1, :only_integer => true

  validates_presence_of :product

  def for_cart
    {:product_id => product_id, :quantity => quantity}
  end

  def price
    quantity * product.price
  end
end
