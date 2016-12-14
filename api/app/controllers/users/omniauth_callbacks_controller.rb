class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.from_omniauth omniauth_params
    
    if provider
      sign_in provider.user
      redirect_to root_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to '/cadastro'
    end
  end
  
  def failure
    redirect_to root_path
  end
end
