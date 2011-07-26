class OrderLine < ActiveRecord::Base
  belongs_to :order

  belongs_to :product, :autosave => false

  validates_numericality_of :quantity, :greater_than_or_equal_to => 1, :only_integer => true

  validates_presence_of :product

  attr_accessible :quantity, :product_id, :product_ids

  before_save :set_unit_price, :set_optional

  def for_cart
    if product_ids.present?
      result = {:product_ids => product_ids}
    else
      result = {:product_id => product_id}
    end
    result[:quantity] = quantity
    result
  end

  def price
    quantity * unit_price
  end

  def unit_price
    super || (product.is_mixture? ? products.sum(&:price) : product.price)
  end

  def product_ids=(ids)
    @product_ids = ids
    roots = products.collect(&:root)
    raise "No way, bro." unless roots.uniq.size == 1
    self.product = roots.first
  end

  def product_ids
    @product_ids ||= optional ? optional[:product_ids] : []
  end

  def products
    @products ||= Product.find(product_ids)
  end

  serialize :optional

  private

  def set_optional
    self.optional ||= {}
    optional[:product_ids] = product_ids
  end

  def set_unit_price
    self.unit_price = unit_price
  end

end
