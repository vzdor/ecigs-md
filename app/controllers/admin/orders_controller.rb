class Admin::OrdersController < AdminController
  before_filter :get_order, :only => [:show, :update]

  def index
    @orders = Order.recent.page(params[:page]).per(25)
  end

  def report
    if (month = params[:from_month]) && (year = params[:from_year])
      from_date = Date.parse("#{year}/#{month}")
    else
      from_date = 1.month.ago
    end
    @order_lines = OrderLine.select("order_lines.*, SUM(order_lines.quantity) AS sold, AVG(order_lines.unit_price) AS avg_unit_price, SUM(order_lines.unit_price) AS total").where("order_lines.created_at > ? ", from_date).group("product_id")
    @order_lines.sort! { |ol1, ol2| ol1.product.title <=> ol2.product.title }
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
