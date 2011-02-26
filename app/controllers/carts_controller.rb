class CartsController < ApplicationController
  def update
    @cart.attributes = params[:order]
    session[:cart] = @cart.for_cart
    redirect_to cart_path
  end

  def delete
    position = params[:position].to_i
    @cart.order_lines.delete_at(position)
    session[:cart] = @cart.for_cart
    redirect_to cart_path
  end
end
