class Product < ActiveRecord::Base

  acts_as_taggable

  has_attached_file :photo, :styles => {
    :thumb => "150x150#",
    :large => "700x700>"
  }

  belongs_to :product

  has_many :assets, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :assets, :allow_destroy => true

  # you should not delete any of the variations, or you get orders or cart messed up. Instead, just set quantity to 0
  has_many :variations, :class_name => 'Product', :order => 'title'
  accepts_nested_attributes_for :variations, :reject_if => proc { |attrs| attrs['title'].blank? && attrs['quantity'].blank? }, :allow_destroy => true

  validates_presence_of :title

  validates_presence_of :description, :unless => :is_variation?

  validates_presence_of :quantity, :unless => :has_variations?

  validates_numericality_of :quantity, :only_integer => true, :unless => :has_variations?

  validates_presence_of :price, :unless => :is_variation?

  validates_numericality_of :price, :greater_than => 0, :unless => :is_variation?
  scope :top, where(:product_id => nil, :is_discontinued => false).order("position desc, created_at asc") do
    def discontinued
      where(:is_discontinued => true)
    end
  end # Without variations and discontinued

  scope :in_stock, top.where("quantity > 0")

  scope :discontinued, top.where(:is_discontinued => true)

  def in_stock?
    quantity.to_i > 0
  end

  def is_variation?
    product_id.present?
  end

  def has_variations?
    variations.present?
  end

  def to_param
    "#{id}-#{title.scan(/\w+/).join('-')}"
  end

  def price
    price = super
    price.nil? && is_variation? ? product.price : price
  end

  def is_variable_price?
    @is_variable_price ||= (product_id || has_variations?) && variations.detect { |v| v.price != price }.present?
  end

  def lowest_variation_price
    variations.minimum(:price)
  end

  def short_summary
    summary.present? ? summary : description
  end

  def root
    r = self
    r = r.product while r.product
    r
  end

  def variation_crumb
    crumb = [title]
    p = self
    crumb << p.title while p = p.product
    crumb[0...2].reverse.join(": ")
  end
end
