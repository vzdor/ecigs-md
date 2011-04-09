require "spec_helper"

describe UserMailer do
  it "new_order_email" do
    order = Factory(:order)
    UserMailer.new_order_email(order).deliver
  end
end
