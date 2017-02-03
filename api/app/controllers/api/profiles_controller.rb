class Api::ProfilesController < ApplicationController
  def index
    @users = User.joins(:providers).where("providers.provider" => "facebook")
  end
end
