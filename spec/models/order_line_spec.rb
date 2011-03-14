require 'spec_helper'

describe OrderLine do
  it "should not be valid without product" do
    ol = OrderLine.new(:quantity => 10)
    ol.should_not be_valid
    ol.product = Factory(:product)
    ol.should be_valid
  end
end
