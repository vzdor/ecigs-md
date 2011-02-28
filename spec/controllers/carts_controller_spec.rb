require 'spec_helper'

describe CartsController do
  render_views

  @@order_options = {'notes' => "test", 'order_lines_attributes' => {
      0 => {'product_id' => Factory(:ego).id, 'quantity' => 12},
      1 => {'product_id' => Factory(:ego).id, 'quantity' => 14},
    }
  }.freeze

  it "should render show" do
    get :show
    response.should be_success
  end

  it "should update" do
    order = Order.new(@@order_options)
    Order.should_receive(:new).and_return(order)
    order.should_receive(:attributes=).with(@@order_options)
    get :update, :order => @@order_options
    response.should be_redirect
    response.should redirect_to(cart_path)
    session[:cart].should == order.for_cart
  end

  it "should delete a product from cart" do
    session[:cart] = @@order_options
    order = Order.new(session[:cart])
    Order.should_receive(:new).with(session[:cart]).and_return(order)
    order.order_lines.should_receive(:delete_at).with(1)
    get :delete, :position => 1
    response.should be_redirect
    response.should redirect_to(cart_path)
    session[:cart].should == order.for_cart
  end

  it "should not update invalid order" do
    order = Order.new(@@order_options)
    Order.should_receive(:new).and_return(order)
    order.should_receive(:valid?).and_return(false)
    get :update, :order => @@order_options
    session[:cart].should be_nil
    flash[:error].should_not be_nil
  end
end
