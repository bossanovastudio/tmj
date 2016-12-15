class Users::OmniauthCallbacksController < ApplicationController
  before_action :authenticate_user!, only: [:remove]
  
  def facebook
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.find_with_omniauth omniauth_params
    
    if provider
      sign_in provider.user
    elsif user_signed_in?
      current_user.providers.create_with_omniauth omniauth_params
    end
    
    redirect_to :back
  end
  
  def twitter
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.find_with_omniauth omniauth_params
    
    if provider
      sign_in provider.user
    elsif user_signed_in?
      current_user.providers.create_with_omniauth omniauth_params
    end
    
    redirect_to :back
  end
  
  def instagram
    omniauth_params = request.env["omniauth.auth"]
    provider = Provider.find_with_omniauth omniauth_params
    
    if provider
      sign_in provider.user
    elsif user_signed_in?
      current_user.providers.create_with_omniauth omniauth_params
    end
    
    redirect_to :back
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
