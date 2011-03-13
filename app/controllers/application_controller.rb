class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_cart

  before_filter :set_tab

  protected

  helper_method :is_admin?
  def is_admin?
    current_user.try(:is_admin)
  end

  def is_admin_filter
    unless is_admin?
      flash[:error] = "Admin privileges required to do this."
      redirect_to new_user_session_path
    end
  end

  def get_cart
    @cart ||= Order.new(session[:cart] || {})
  end

  def reset_cart
    session[:cart] = nil
  end

  def set_tab
    @tab = :products
  end

end
