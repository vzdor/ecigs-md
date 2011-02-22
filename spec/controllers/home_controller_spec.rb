require 'spec_helper'

describe HomeController do
  render_views

  it "should render index page" do
    get :index
    response.should be_success
  end
end
