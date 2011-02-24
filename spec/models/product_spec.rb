require 'spec_helper'

describe Product do
  it "should be valid" do
    product = Product.new(:title => "test", :quantity => 123, :price => 123, :description => "hello world")
    product.should be_valid
  end

  it "should accept photo" do
    product = Factory(:ego)
    product.attributes = {:photo => File.open(Rails.root + "public/images/rails.png")}
    product.should be_valid
    product.reload.photo.file?.should == true
  end

  it "should accept multiple assets" do
    product = Factory(:ego)
    photo = File.open(Rails.root + "public/images/rails.png")
    product.assets_attributes = {0 => {:blob => photo}, 1 => {:blob => photo}}
    product.should be_valid
    product.assets.size.should == 2
  end

  it "variation should only require title and quantity" do
    product = Factory(:ego)
    variation = product.variations.build(:title => "test", :quantity => 10)
    variation.should be_valid
  end

  it "should accept a list of variations and reject empty ones" do
    product = Factory(:ego)
    product.variations_attributes = {0 => {:title => 'test', :quantity => 12}, 1 => {:title => ''}}
    product.should be_valid
    product.variations.size.should == 1
  end

  it "top scope should return products, not variations" do
    Product.top.to_sql.should == 'SELECT `products`.* FROM `products` WHERE (product_id IS NULL)'
  end
end
