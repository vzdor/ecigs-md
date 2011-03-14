class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_lines
  accepts_nested_attributes_for :order_lines, :allow_destroy => true, :reject_if => proc { |attrs| attrs[:quantity].to_i <= 0 }

  has_many :products, :through => :order_lines

  has_one :order_address
  accepts_nested_attributes_for :order_address

  scope :recent, order('created_at')

  attr_accessible :notes, :order_lines_attributes, :order_address_attributes

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

  def delivery_cost
    self.class.delivery_cost
  end

  def total
    order_lines.map(&:price).sum
  end

  def total_with_delivery
    total + delivery_cost
  end

  # todo: update quantity if the same product
  # alias_method :orig_order_lines_attributes=, :order_lines_attributes=

  # def order_lines_attributes=(attributes)

  # end

  class << self
    def delivery_cost
      25
    end
  end
end
