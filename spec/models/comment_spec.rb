require 'spec_helper'

describe Comment do
  it "should set user.fullname" do
    user = Factory(:user, :fullname => nil)
    user.should_receive(:fullname=).with("bob")
    user.should_receive(:save!)
    Factory(:comment, :fullname => "bob", :user => user)
  end
end
