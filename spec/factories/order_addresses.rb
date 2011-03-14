Factory.define :order_address, :class => OrderAddress do |address|
  address.association :order
  address.association :user
  address.city 'Chisinau'
  address.street 'Ghibu 2'
  address.phone_number '1111111111'
  address.phone_number2 '2222222222'
end
