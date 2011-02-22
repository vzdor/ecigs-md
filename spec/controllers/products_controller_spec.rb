require 'spec_helper'

describe ProductsController do
  render_views

  it "should render new" do
    login_admin
    get :new
    response.should be_success
  end

  it "should add a new product" do
    login_admin
    product = Product.new(:title => "test", :description => "test", :price => 12, :quantity => 10)
    Product.should_receive(:new).with(product.attributes).and_return(product)
    proc {
      post :create, :product => product.attributes
    }.should change(Product, :count).by(1)
    response.should be_redirect
    response.should redirect_to(product_path(product))
  end

  it "user with is_admin = false should not be allowed to add a new product" do
    proc {
      post :create, :product => {:title => "test", :description => "test", :price => 12, :quantity => 10}
    }.should_not change(Product, :count)
  end
end
