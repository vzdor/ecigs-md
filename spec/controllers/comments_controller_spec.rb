require 'spec_helper'

describe CommentsController do
  render_views

  before do
    @user = Factory(:user)
    sign_in(@user)
  end

  it "should add a comment" do
    product = Factory(:product)
    proc do
      xhr :post, :create, :product_id => product.id, :comment => {:score => 4, :content => "test test", :fullname => "test bob"}
      response.should be_success
      response.body.should == "window.location.href = \"#{product_path(product)}\";"
    end.should change(Comment, :count).by(1)
  end

  it "should render NotFound if is_commentable -> false" do
    product = Factory(:product, :is_commentable => false)
    proc do
      xhr :post, :create, :product_id => product.id, :comment => {:score => 4, :content => "test test", :fullname => "test bob"}
    end.should raise_error(ActiveRecord::RecordNotFound)
  end
end
