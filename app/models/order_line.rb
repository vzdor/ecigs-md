class OrderLine < ActiveRecord::Base
  belongs_to :order

  belongs_to :product, :autosave => false

  validates_numericality_of :quantity, :greater_than_or_equal_to => 1, :only_integer => true

  validates_presence_of :product

  attr_accessor :product_ids
  attr_accessible :quantity, :product_id, :product_ids

  before_save :set_unit_price, :save_mixture

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
    quantity * (unit_price || product.price)
  end

  def product_ids=(ids)
    @product_ids = ids
    products = Product.find(ids)
    roots = products.collect(&:root)
    raise "No way, bro." unless roots.uniq.size == 1
    self.product = Mixture.from_order_products(products)
  end

  private

  def save_mixture
    if product.new_record?
      begin
        product.save!
      rescue ActiveRecord::RecordNotUnique
        self.product = Mixture.find_by_mixture_hash(product.mixture_hash)
     end
      self.product_id = product.id
    end
  end

  def set_unit_price
    self.unit_price = product.price
  end

end
