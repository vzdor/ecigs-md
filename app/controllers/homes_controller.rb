class HomesController < ApplicationController

  private

  def set_tab
    @tab = action_name.to_sym
  end
end
