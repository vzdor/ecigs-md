class Order < ActiveRecord::Base
  belongs_to :user

  has_many :order_lines
  accepts_nested_attributes_for :order_lines, :allow_destroy => true, :reject_if => proc { |attrs| attrs[:quantity].to_i <= 0 }

  has_many :products, :through => :order_lines

  has_one :order_address
  accepts_nested_attributes_for :order_address

  after_update :update_product_quantity

  # validates_presence_of :order_address, :if => :include_delivery?

  class Status
    PROCESSING = 0
    DELIVERY = 1
    SHIPPED = 2
    CANCELLED = 3

    CAPTIONS = {
      PROCESSING => :processing,
      DELIVERY => :delivery,
      SHIPPED => :shipped,
      CANCELLED => :cancelled
    }
  end

  scope :recent, order('status, created_at desc')

  attr_accessible :notes, :order_lines_attributes, :order_address_attributes, :include_delivery

  def for_cart
    hash = {}
    hash[:order_lines_attributes] = order_lines.collect(&:for_cart)
    hash
  end

  attr_accessor :_replace_order_lines

  def attributes=(attributes, protect = true)
    order_lines.delete_all if attributes[:_replace_order_lines]
    super(attributes, protect)
  end

  def delivery_cost
    include_delivery? ? self.class.delivery_cost : 0.0
  end

  def total
    order_lines.map(&:price).sum
  end

  def total_with_delivery
    include_delivery? ? total + delivery_cost : total
  end

  # todo: update quantity if the same product
  # alias_method :orig_order_lines_attributes=, :order_lines_attributes=

  # def order_lines_attributes=(attributes)

  # end

  class << self
    def delivery_cost
      25.0
    end
  end

  protected

  def update_product_quantity
    if status_changed?
      if status == Status::SHIPPED
        order_lines.each { |l| l.product.decrement!(:quantity, l.quantity) }
      elsif status_was == Status::SHIPPED
        order_lines.each { |l| l.product.increment!(:quantity, l.quantity) }
      end
    end
  end

end
