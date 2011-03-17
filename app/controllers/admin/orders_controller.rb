class Admin::OrdersController < AdminController
  before_filter :get_order, :only => [:show, :update]

  def index
    @orders = Order.recent.page(params[:page]).per(25)
  end

  def update
    @order.send(:attributes=, params[:order], false)
    if @order.save
      flash[:notice] = "Order updated successfully."
      redirect_to admin_orders_path
    else
      render :action => "show"
    end
  end

  protected

  def get_order
    @order = Order.find(params[:id])
  end
end
