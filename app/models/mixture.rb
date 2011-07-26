class Mixture < Product
  has_many :mixture_products

  has_many :products, :through => :mixture_products

  before_save :set_mixture_hash

  def price
    # todo
    mixture_products.map(&:product).sum(&:price)
  end

  def title
    product.title
  end

  class << self
    def mixture_hash(products)
      products.map(&:id).join('-')
    end

    def build_new(products)
      root = products.first.root
      this = new(:quantity => 1, :is_producible => true)
      this.product = root
      products.each { |p| this.mixture_products.build(:product => p) }
      this
    end

    def from_order_products(products)
      find_by_mixture_hash(mixture_hash(products)) || build_new(products)
    end
  end

  protected

  def set_mixture_hash
    self.mixture_hash = Mixture.mixture_hash(mixture_products.map(&:product))
  end
end
