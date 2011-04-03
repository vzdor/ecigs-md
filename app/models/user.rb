class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :orders, :order => "id desc"

  has_many :order_addresses

  def display_name
    email.split('@').first + '@..'
  end

  def address_for_order
    address = order_addresses.first
    address ? address.clone : OrderAddress.new
  end
end
