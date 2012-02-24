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
      get :edit, :id => Factory(:product).id
      response.should be_success
    end

    it "should update a product" do
      product = Factory(:product)
      Product.should_receive(:find).with(product.id).and_return(product)
      product.should_receive(:attributes=).with('title' => "Hello")
      product.should_receive(:save).and_return(true)
      put :update, :id => product.id, :product => {:title => "Hello"}
      response.should be_redirect
      response.should redirect_to(product_path(product))
    end
  end

  it "find wiki page without a tag" do
    vis = mock()
    WikiPage.should_receive(:visible).and_return(vis)
    vis.should_receive(:find_by_slug).with("products-index")
    get :index
  end

  it "find wiki page with tag" do
    vis = mock()
    WikiPage.should_receive(:visible).and_return(vis)
    vis.should_receive(:find_by_slug).with("flavors")
    get :index, :tag => 'flavors'
  end

  it "should not be allowed to add a new product" do
    proc {
      post :create, :product => {:title => "test", :description => "test", :price => 12, :quantity => 10}
    }.should_not change(Product, :count)
  end

  it "should not be allowed to edit a product" do
    Product.should_not_receive(:find)
    put :update, :id => Factory(:product).id, :product => {:title => "test"}
  end

  it "should render show" do
    get :show, :id => Factory(:product).id
    response.should be_success
  end

  it "should render show with mixture" do
    get :show, :id => Factory(:mixture).id
    response.should be_success
  end

  it "should render index" do
    get :index

    response.should be_success
  end

  it "should render discontinued" do
    top = Product.top
    discontinued = top.discontinued
    Product.should_receive(:top).twice().and_return(top)
    top.should_receive(:discontinued).and_return(discontinued)
    get :index, :discontinued => :y
    response.should be_success
  end

  it "should filter by tag" do
    product1 = Factory(:product, :tag_list => "ego")
    product2 = Factory(:product, :tag_list => "ego-t")

    get :index, :tag => "ego"
    response.should be_success
    results = assigns[:products]
    results.should_not be_nil
    results.first.id == product1.id

    get :index, :tag => "ego-t"
    response.should be_success
    results = assigns[:products]
    results.should_not be_nil
    results.first.id == product2.id
  end

  it "should render show with comments" do
    product = Factory(:product)
    5.times { Factory(:comment, :commentable => product) }
    get :index, :id => product.id
    response.should be_success
  end
end
