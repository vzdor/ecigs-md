class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = @cart.clone
    order_address = current_user.order_addresses.first
    @order.order_address = order_address ? order_address.clone : OrderAddress.new
  end

  def create
    @order = Order.new(params[:order])
    @order.attributes = @cart.for_cart # todo: looks stupid
    @order.user = current_user
    @order.order_address.user = current_user
    if @order.save
      reset_cart
      flash[:notice] = "Order submitted successfully. Thank you. We will contant you shortly."
      redirect_to @order
    else
      render :action => "new"
    end
  end

  def index
    @orders = current_user.orders
  end
end
