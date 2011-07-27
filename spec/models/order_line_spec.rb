require 'spec_helper'

describe OrderLine do
  it "should not be valid without product" do
    ol = OrderLine.new(:quantity => 10)
    ol.should_not be_valid
    ol.product = Factory(:product)
    ol.should be_valid
  end

  it "should save unit price" do
    order_line = OrderLine.new(:quantity => 10)
    product = Factory(:product)
    order_line.product = product
    order_line.order = Factory(:order)
    order_line.save.should == true
    order_line.unit_price.should == product.price
  end

  describe "mixtures" do
    before do
      @mixture = Factory(:mixture)
      @products = [@mixture.variations.first.variations.first,
                   @mixture.variations.last.variations.first]
    end

    it "product_ids=" do
      ol = OrderLine.new(:product_ids => @products.map(&:id))
      ol.product.should == @mixture
    end

    it "unit_price" do
      ol = OrderLine.new
      ol.stub(:product).and_return(@mixture)
      ol.stub(:products).and_return(@products)
      sum = @products.sum(&:price) + @mixture.price
      ol.unit_price.should == sum
    end

    it "should save product_ids" do
      ids = @products.map(&:id)
      ol = OrderLine.new(:quantity => 10, :product_ids => ids)
      ol.order = Factory(:order)
      ol.save
      ol.reload
      ol.optional[:product_ids].should == ids
    end

    it "for_cart" do
      ids = @products.map(&:id)
      ol = OrderLine.new(:quantity => 10, :product_ids => ids)
      ol.for_cart.should == {:product_ids => @products.map(&:id), :quantity => 10}
    end
  end
end
