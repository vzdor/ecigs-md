# -*- coding: utf-8 -*-
class CartsController < ApplicationController
  before_filter :stop_new_orders

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

  def stop_new_orders
    flash[:error] = "Извините, больше не принимаю заказы."
    redirect_to root_path
  end
end
