class RedirController < ApplicationController
  before_action :authenticate_user!

  def profile
    redirect to: "/perfil/#{current_user.username}"
  end
end
