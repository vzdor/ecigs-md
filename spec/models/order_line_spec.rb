require 'spec_helper'

describe OrderLine do
  it "should not be valid without product" do
    ol = OrderLine.new(:quantity => 10)
    ol.should_not be_valid
    ol.product = Factory(:product)
    ol.should be_valid
  end

  it "should save unit price" do
    order_line = OrderLine.new(:quantity => 10)
    product = Factory(:product)
    order_line.product = product
    order_line.order = Factory(:order)
    order_line.save.should == true
    order_line.unit_price.should == product.price
  end
end
