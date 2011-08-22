require 'spec_helper'

describe Admin::CommentsController do
  render_views

  before do
    login_admin
    @comment = Factory(:comment)
    @comment2 = Factory(:comment)
  end

  before(:type => :controller) do
    request.env["HTTP_REFERER"] = "/"
  end

  it "should render index" do
    get :index
    response.should be_success
  end

  it "should update" do
    Comment.should_receive(:find).with(@comment.id).and_return(@comment)
    @comment.should_receive(:attributes=)
    @comment.should_receive(:save!)
    put :update, :id => @comment.id, :comment => {:content => "test"}
    response.should be_redirect
  end

  it "should destroy" do
    Comment.should_receive(:find).with(@comment.id).and_return(@comment)
    @comment.should_receive(:destroy)
    delete :destroy, :id => @comment.id
    response.should redirect_to('/')
  end

end
