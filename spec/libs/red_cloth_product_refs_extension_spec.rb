require 'spec_helper'

describe RedClothProductRefsExtension do
  it "should link to product" do
    input = 'test *test* [[p:123]] test'
    html = '<p>test <strong>test</strong> <a href="/products/123">#123</a> test</p>'
    RedCloth.new(input).to_html(:textile, :product_refs).should == html
  end
end
