class HomesController < ApplicationController

  private

  def set_tab
    @tab = action_name.camelize
  end
end
