class Admin::OrdersController < AdminController
  def index
    @orders = Order.recent.page(params[:page]).per(25)
  end

  def show
    @order = Order.find(params[:id])
  end
end
