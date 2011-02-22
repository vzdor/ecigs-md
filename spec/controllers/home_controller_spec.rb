require 'spec_helper'

describe HomeController do
  it "should render index page" do
    get :index
    response.should be_success
  end
end
