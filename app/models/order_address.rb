class OrderAddress < ActiveRecord::Base
  belongs_to :user

  belongs_to :order

  attr_accessible :city, :street, :phone_number, :phone_number2

  validates_presence_of :street

  validates_presence_of :phone_number
end
