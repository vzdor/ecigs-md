require 'spec_helper'

describe ProductsController do
  render_views

  describe "with admin privileges" do
    before do
      login_admin
    end

    it "should render new" do
      get :new
      response.should be_success
    end

    it "should add a new product" do
      product = Product.new(:title => "test", :description => "test", :price => 12, :quantity => 10)
      Product.should_receive(:new).with(product.attributes).and_return(product)
      proc {
        post :create, :product => product.attributes
      }.should change(Product, :count).by(1)
      response.should be_redirect
      response.should redirect_to(product_path(product))
    end

    it "should render edit" do
      get :edit, :id => Factory(:ego).id
      response.should be_success
    end

    it "should update a product" do
      product = Factory(:ego)
      Product.should_receive(:find).with(product.id).and_return(product)
      product.should_receive(:attributes=).with('title' => "Hello")
      product.should_receive(:save).and_return(true)
      put :update, :id => product.id, :product => {:title => "Hello"}
      response.should be_redirect
      response.should redirect_to(product_path(product))
    end
  end

  it "should not be allowed to add a new product" do
    proc {
      post :create, :product => {:title => "test", :description => "test", :price => 12, :quantity => 10}
    }.should_not change(Product, :count)
  end

  it "should not be allowed to edit a product" do
    Product.should_not_receive(:find)
    put :update, :id => Factory(:ego).id, :product => {:title => "test"}
  end

  it "should render show" do
    get :show, :id => Factory(:ego).id
    response.should be_success
  end

  it "should render index" do
    get :index
    response.should be_success
  end
end
