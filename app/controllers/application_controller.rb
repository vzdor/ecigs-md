class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_cart

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

end
