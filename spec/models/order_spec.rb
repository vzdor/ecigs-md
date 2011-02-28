require 'spec_helper'

describe Order do
  it "order_lines_attributes = should replace order lines" do
    order = Order.new
    order.order_lines.should_receive(:delete_all)
    order.attributes = {:order_lines_attributes => {0 => {:product_id => 1, :quantity => 1}}, :_replace_order_lines => true}
  end
end
