require 'spec_helper'

describe OrdersController do
  render_views

  describe 'logged in' do

    before do
      @user = Factory(:user)
      sign_in(@user)
    end

    it "should render show" do
      order = Factory(:order, :user => @user)
      get :show, :id => order.id
      response.should be_success
    end

    it "should render index" do
      2.times { Factory(:order, :user => @user) }
      get :index
      response.should be_success
    end

    it "should render new" do
      order = Factory(:order)
      session[:cart] = order.for_cart
      get :new
      response.should be_success
    end

    it "should create an order" do
      order = Factory.build(:order)
      session[:cart] = order.for_cart
      proc do
        post :create, :order => {:order_address_attributes => {:street => '123', :phone_number => '123'}, :notes => 'test'}
        response.should be_redirect
      end.should change(Order, :count).by(1)
    end

    it "should send new order email" do
      order = Factory.build(:order)
      session[:cart] = order.for_cart
      mailer = mock()
      UserMailer.should_receive(:new_order_email).and_return(mailer)
      mailer.should_receive(:deliver)
      post :create, :order => {:order_address_attributes => {:street => '123', :phone_number => '123'}, :notes => 'test'}
    end

    it "should not submit the order" do
      order = Factory.build(:order)
      session[:cart] = order.for_cart
      proc do
        post :create, :order => {:order_address_attributes => {:street => '123', :phone_number => '123'}, :notes => 'test'}, :dont_submit => "yes"
        response.should be_success
      end.should_not change(Order, :count)
    end
  end

  describe 'logged as superuser' do

    before do
      @user = Factory(:user, :is_admin => true)
      sign_in(@user)
    end

    it "should not send new order email if submitted by me" do
      order = Factory.build(:order)
      session[:cart] = order.for_cart
      UserMailer.should_not_receive(:new_order_email)
      post :create, :order => {:order_address_attributes => {:street => '123', :phone_number => '123'}, :notes => 'test'}
    end

    it "should redirect to admin order view" do
      order = Factory.build(:order)
      session[:cart] = order.for_cart
      post :create, :order => {:order_address_attributes => {:street => '123', :phone_number => '123'}, :notes => 'test'}
      response.should redirect_to(admin_order_path(Order.last))
    end
  end
end
