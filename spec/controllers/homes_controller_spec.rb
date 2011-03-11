require 'spec_helper'

describe HomesController do
  render_views

  it "should render show page" do
    get :show
    response.should be_success
  end

  it "should render contacts" do
    get :contacts
    response.should be_success
  end

  it "should render delivery" do
    get :delivery
    response.should be_success
  end
end
