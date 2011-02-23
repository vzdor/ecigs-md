class Product < ActiveRecord::Base

  acts_as_taggable

  validates_presence_of :title

  validates_presence_of :description

  validates_presence_of :quantity

  validates_numericality_of :quantity, :greater_than => 0

  validates_presence_of :price

  validates_numericality_of :price, :greater_than => 0

  scope :in_stock, :conditions => "quantity > 0", :order => "created_at"

  def in_stock?
    quantity > 0
  end

  def to_param
    "#{id}-#{title.scan(/\w+/).join('-')}"
  end
end
