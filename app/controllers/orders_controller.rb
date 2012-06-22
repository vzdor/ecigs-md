class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @order = @cart.clone
    @order.order_address = current_user.address_for_order
  end

  def create
    @order = Order.new(params[:order])
    @order.attributes = @cart.for_cart # todo: looks stupid
    @order.user = current_user
    @order.order_address.user = current_user if @order.order_address # include_delivery => false
    if params[:dont_submit].blank? && @order.save
      reset_cart
      flash[:notice] = t(:order_submitted)
      if @order.user.is_admin?
        redirect_to admin_order_path(@order)
      else
        UserMailer.new_order_email(@order).deliver
        redirect_to @order
      end
    else
      @order.order_address ||= current_user.address_for_order
      render :action => "new"
    end
  end

  def index
    @orders = current_user.orders
  end
end
