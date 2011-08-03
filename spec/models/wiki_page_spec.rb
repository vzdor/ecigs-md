require 'spec_helper'

describe WikiPage do
  it "slug should be uniq" do
    w = Factory(:wiki_page)
    w2 = WikiPage.new(:title => w.title, :content => "test")
    w2.should_not be_valid
    w2.should have(1).error_on(:slug)
  end
end
