require 'spec_helper'

describe Order do
  it "order_lines_attributes = should replace order lines" do
    order = Order.new
    order.order_lines.should_receive(:delete_all)
    order.attributes = {:order_lines_attributes => {0 => {:product_id => 1, :quantity => 1}}, :_replace_order_lines => true}
  end

  it "should include_delivery by default" do
    order = Order.new
    order.include_delivery.should == true
  end

  describe "total_with_delivery" do
    it "should include delivery cost" do
      order = Order.new
      order.total_with_delivery.should == Order.delivery_cost
    end

    it "should not include delivery_cost if include_delivery is false" do
      order = Order.new
      order.include_delivery = false
      order.total_with_delivery.should == 0
    end
  end
end
