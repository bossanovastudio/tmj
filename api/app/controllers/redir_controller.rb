class RedirController < ApplicationController
  before_action :authenticate_user!

  def profile
    redirect_to "/perfil/#{current_user.username}"
  end
end
