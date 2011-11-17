require 'spec_helper'

describe Product do
  it "should be valid" do
    product = Product.new(:title => "test", :quantity => 123, :price => 123, :description => "hello world")
    product.should be_valid
  end

  it "should accept photo" do
    product = Factory(:product)
    product.attributes = {:photo => File.open(Rails.root + "public/images/rails.png")}
    product.should be_valid
    product.reload.photo.file?.should == true
  end

  it "should accept multiple assets" do
    product = Factory(:product)
    photo = File.open(Rails.root + "public/images/rails.png")
    product.assets_attributes = {0 => {:blob => photo}, 1 => {:blob => photo}}
    product.should be_valid
    product.assets.size.should == 2
  end

  it "should add a new product with variations and filter blank variations" do
    product = Product.new(:title => "test", :description => "test", :price => 10, :variations_attributes => {0 => {:title => 'test', :quantity => 12, :product_id => 0}, 1 => {:title => ''}})
    product.should be_valid
    product.variations.size.should == 1
  end

  it "variation should only require title and quantity" do
    product = Factory(:product)
    variation = product.variations.build(:title => "test", :quantity => 10)
    variation.should be_valid
  end

  it "top scope should return products, not variations" do
    Product.top.where_values_hash.should include(:product_id => nil, :is_discontinued => false)
  end

  it "top.discontinued show return only discontinued products" do
    Product.top.discontinued.where_values_hash.should include(:is_discontinued => true)
  end

  it "has_variations?" do
    product = Product.new
    product.has_variations?.should == false
    product.variations.build
    product.has_variations?.should == true
  end

  it "is_variation?" do
    product = Product.new
    product.is_variation?.should == false
    product.product_id = 1
    product.is_variation?.should == true
  end

  it "price_varies?" do
    product = Factory(:product)
    product.variations.build
    product.price_varies?.should == false
    product.variations.build(:price => product.price + 1)
    product.price_varies?.should == true
  end

  it "lowest_price" do
    product = Factory(:product)
    v = product.variations.create!(:title => "test 1", :quantity => 2, :price => 1)
    product.variations.create!(:title => "test 2", :quantity => 2, :price => 2)
    product.lowest_price.should == v.price
  end

  it "short_summary" do
    product = Product.new(:description => 'test')
    product.short_summary.should == product.description
    product.summary = 'test summary'
    product.short_summary.should == product.summary
  end

  it "sorted_variations" do
    product = Factory(:product)
    v10 = product.variations.build(:title => "10", :quantity => 10)
    v5 = product.variations.build(:title => "5", :quantity => 10)
    product.sorted_variations.should == [v10, v5]
    product.numeric_sort = true
    product.sorted_variations.should == [v5, v10]
  end
end
