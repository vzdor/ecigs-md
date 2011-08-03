require 'spec_helper'

describe WikiPagesController do
  before do
    @wiki = Factory(:wiki_page)
    @wiki2 = Factory(:wiki_page, :is_visible => false)
  end

  describe "as admin" do
    before do
      login_admin
    end

    it "should render index" do
      get :index
      response.should be_success
    end

    it "should render edit" do
      get :edit, :id => @wiki.to_param
      response.should be_success
    end

    it "should update" do
      c = @wiki.content + "hello"
      WikiPage.should_receive(:find_by_slug!).and_return(@wiki)
      put :update, :id => @wiki.to_param, :wiki_page => {:content => c}
      response.should redirect_to(@wiki)
      @wiki.content.should == c
    end
  end

  it "should render show" do
    get :show, :id => @wiki.to_param
    response.should be_success
  end

  it "should use WikiPage.visible scope" do
    vis = WikiPage.visible
    WikiPage.should_receive(:visible).and_return(vis)
    get :show, :id => @wiki.to_param
  end

  it "should not update" do
    WikiPage.should_not_receive(:find_by_slug!)
    put :update, :id => @wiki.to_param
    response.should redirect_to(new_user_session_path)
  end
end
