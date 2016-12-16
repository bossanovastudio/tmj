class Api::GeneralController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]
  
  def all
    pagination = pagination_params

    @highlight = Highlight.ordered_by_index.published.page(pagination[:page]).per(1).first
    @cards = Card.page(pagination[:page]).per(pagination[:quantity].to_i - 1).approved.ordered
  end

  def highlights
    @highlights = Highlight.published
  end

  def all_without_editors
    pagination = pagination_params
    @cards = Card.left_joins(:user).where({ users: { role: [1, nil] }}).approved.ordered
    @cards_paginated = @cards.page(pagination[:page]).per(pagination[:quantity].to_i - 1)
  end

  def editors
    pagination = pagination_params

    @user = User.editors.where(username: params[:username]).first
    @cards = @user.cards.page(pagination[:page]).per(pagination[:quantity].to_i - 1).not_rejected.ordered
  end
  
  def users
    pagination = pagination_params

    @user = User.find_by!(username: params[:username])
    @cards = @user.cards.page(pagination[:page]).per(pagination[:quantity].to_i - 1).approved.ordered
  end
  
  def profile
    @user = User.find_by!(username: params[:username])
  end
  
  def follow
    user = User.find_by!(username: params[:username])
    current_user.bookmark user
  end
  
  def unfollow
    user = User.find_by!(username: params[:username])
    current_user.unbookmark user
  end

  private
    def pagination_params
      params.permit(:page, :quantity)
    end
end
