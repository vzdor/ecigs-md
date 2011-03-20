module OrdersHelper
  def order_status(order)
    t(Order::Status::CAPTIONS[order.status]).html_safe
  end

  def order_status_select(form)
    form.select(:status, Order::Status::CAPTIONS.map { |k, v| [t(v), k] })
  end
end
