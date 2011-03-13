class Product < ActiveRecord::Base

  acts_as_taggable

  has_attached_file :photo, :styles => {
    :thumb => "150x150#",
    :large => "600x600>"
  }

  belongs_to :product

  has_many :assets, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :assets, :allow_destroy => true

  has_many :variations, :class_name => 'Product', :order => 'title'
  accepts_nested_attributes_for :variations, :allow_destroy => true, :reject_if => proc { |attrs| attrs['title'].blank? && attrs['quantity'].blank? }

  validates_presence_of :title

  validates_presence_of :description, :unless => :is_variation?

  validates_presence_of :quantity, :unless => :has_variations?

  validates_numericality_of :quantity, :greater_than => 0, :unless => :has_variations?

  validates_presence_of :price, :unless => :is_variation?

  validates_numericality_of :price, :greater_than => 0, :unless => :is_variation?
  scope :top, where("product_id IS NULL") # Skip variations

  scope :in_stock, top.where("quantity > 0").order("created_at")

  def in_stock?
    quantity > 0
  end

  def is_variation?
    !product_id.nil?
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

end
