class CartsController < ApplicationController
  def update
    @cart.attributes = params[:order]
    post_update
  end

  def delete
    position = params[:position].to_i
    @cart.order_lines.delete_at(position)
    post_update
  end

  private

  def post_update
    if @cart.valid?
      session[:cart] = @cart.for_cart
    else
      logger.error "cart: #{@cart.errors.inspect}"
      flash[:error] = "There was a problem updating cart."
    end
    redirect_to cart_path
  end
end
