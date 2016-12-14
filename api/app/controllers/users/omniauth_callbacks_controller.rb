class Users::OmniauthCallbacksController < ApplicationController
  before_action :authenticate_user!
  
  def facebook
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.find_with_omniauth omniauth_params
    
    unless provider
      current_user.providers.create_with_omniauth omniauth_params
    end
    
    redirect_to '/editar-perfil'
  end
  
  def twitter
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.find_with_omniauth omniauth_params
    
    unless provider
      current_user.providers.create_with_omniauth omniauth_params
    end
    
    redirect_to '/editar-perfil'
  end
  
  def instagram
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.find_with_omniauth omniauth_params
    
    unless provider
      current_user.providers.create_with_omniauth omniauth_params
    end
    
    redirect_to '/editar-perfil'
  end
  
  def remove
    provider = current_user.providers.find_by(provider: params[:provider])
    
    if provider.any?
      provider.destroy
    end
    
    render json: provider, status: :ok
  end

  def failure
    redirect_to root_path
  end
end
