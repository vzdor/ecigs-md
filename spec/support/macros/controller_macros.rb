module ControllerMacros
  def login_admin
    sign_in Factory(:admin)
  end
end
