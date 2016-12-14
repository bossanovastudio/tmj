class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.find_with_omniauth omniauth_params

    unless provider
      current_user.providers.create_with_omniauth omniauth_params
    end

    redirect_to '/editar-perfil'
  end

  def failure
    redirect_to root_path
  end
end
