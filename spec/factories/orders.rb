Factory.define :order, :class => Order do |order|
  order.after_build do |o|
    o.order_lines = [Factory.build(:order_line, :order => o)]
    o.order_address = Factory.build(:order_address, :order => o, :user => o.user)
  end
  order.status Order::Status::PROCESSING
  order.association :user
  order.notes 'please do that and do this'
end
