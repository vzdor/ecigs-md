require 'spec_helper'

describe Admin::OrdersController do
  render_views

  it "should not render index" do
    sign_in(Factory(:user))
    get :index
    response.should be_redirect
  end

  describe "with admin user" do
    before do
      login_admin
    end

    it "should render index" do
      Factory(:order)
      Factory(:order)
      get :index
      response.should be_success
    end

    it "should render show" do
      order = Factory(:order)
      get :show, :id => order.id
      response.should be_success
    end
  end
end
