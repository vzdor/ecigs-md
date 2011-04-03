require 'spec_helper'

describe User do
  it "address_for_order should make a new address" do
    OrderAddress.should_receive(:new)
    user = Factory(:user)
    user.address_for_order
  end
end
