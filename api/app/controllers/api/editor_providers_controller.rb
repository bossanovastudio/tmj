class Api::EditorProvidersController < ApplicationController
  def index
    @users = User.editors
  end
end
