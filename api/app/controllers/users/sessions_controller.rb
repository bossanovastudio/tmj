class Users::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, only: [:failure]
  respond_to :json

  def create
    resource = User.find_for_database_authentication(username: params[:user][:username])
    return failure unless resource

    if resource.valid_password?(params[:user][:password])
      if params[:user][:remember_me]
        resource.remember_me!
      end

      sign_in(resource_name, resource)
      render json: { user: resource }, status: :ok
    else
      failure
    end
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    render json: { :status => :ok }
  end


  def is_signed_in
    unless current_user
      render json: { error: I18n.t('authentication.user_not_signed_in') }, status: :unauthorized
    else
      render json: { user: current_user }, status: :ok
    end
  end

  private
  def failure
    render json: { error: I18n.t('authentication.invalid_username_or_password') }, status: :unauthorized
  end
end