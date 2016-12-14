class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.from_omniauth omniauth_params
    
    unless provider
      Provider.create_with_omniauth omniauth_params
    end
    
    redirect_to '/sua-pagina'
  end
  
  def failure
    redirect_to root_path
  end
end
