require 'spec_helper'

describe Order do
  it "order_lines_attributes = should replace order lines" do
    order = Order.new
    order.order_lines.should_receive(:delete_all)
    order.attributes = {:order_lines_attributes => {0 => {:product_id => 1, :quantity => 1}}, :_replace_order_lines => true}
  end

  it "should include_delivery by default" do
    Order.stub!(:delivery_off?).and_return(false)
    order = Order.new
    order.include_delivery.should == true
  end

  it "should not include_delivery if delivery_off?" do
    Order.stub!(:delivery_off?).and_return(true)
    order = Order.new
    order.include_delivery.should == false
  end

  describe "total_with_delivery" do
    it "should include delivery cost" do
      Order.stub!(:delivery_off?).and_return(false)
      order = Order.new
      order.total_with_delivery.should == Order.delivery_cost
    end

    it "should not include delivery_cost if include_delivery is false" do
      order = Order.new
      order.include_delivery = false
      order.total_with_delivery.should == 0
    end
  end

  it "should increment product quantity when shipped" do
    order = Factory(:order)
    order_line = order.order_lines.first
    order.status = Order::Status::SHIPPED
    proc { order.save! }.should change(order_line.product, :quantity).by(-order_line.quantity)
  end

  it "should not increment product quantity if is_producible?" do
    order = Factory(:order)
    order_line = order.order_lines.first
    order_line.product.is_producible = true
    order.status = Order::Status::SHIPPED
    proc { order.save! }.should_not change(order_line.product, :quantity)
  end

  it "should not increment product quantity if is_mixture?" do
    order = Factory(:order)
    order_line = order.order_lines.first
    order_line.product.is_mixture = true
    order.status = Order::Status::SHIPPED
    proc { order.save! }.should_not change(order_line.product, :quantity)
  end

  it "should rollback quantity when status changes from shipped" do
    order = Factory(:order, :status => Order::Status::SHIPPED)
    order_line = order.order_lines.first
    order.status = Order::Status::CANCELLED
    proc { order.save! }.should change(order_line.product, :quantity).by(order_line.quantity)

  end
end
