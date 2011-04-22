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
  accepts_nested_attributes_for :variations, :reject_if => proc { |attrs| attrs['title'].blank? && attrs['quantity'].blank? }

  validates_presence_of :title

  validates_presence_of :description, :unless => :is_variation?

  validates_presence_of :quantity, :unless => :has_variations?

  validates_numericality_of :quantity, :only_integer => true, :unless => :has_variations?

  validates_presence_of :price, :unless => :is_variation?

  validates_numericality_of :price, :greater_than => 0, :unless => :is_variation?
  scope :top, where("product_id IS NULL").order("position desc, created_at asc") # Skip variations

  scope :in_stock, top.where("quantity > 0")

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

  def short_summary
    summary.present? ? summary : description
  end

end
