Factory.define :order_line, :class => OrderLine do |ol|
  ol.association :order
  ol.association :product
  ol.quantity 10
  ol.unit_price 10
end
