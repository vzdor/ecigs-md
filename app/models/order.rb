class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_lines
  accepts_nested_attributes_for :order_lines, :allow_destroy => true, :reject_if => proc { |attrs| attrs[:quantity].to_i <= 0 }

  def for_cart
    hash = {:notes => notes}
    hash[:order_lines_attributes] = order_lines.collect(&:for_cart)
    hash
  end

  attr_accessor :_replace_order_lines

  def attributes=(attributes)
    order_lines.delete_all if attributes[:_replace_order_lines]
    super(attributes)
  end
end
