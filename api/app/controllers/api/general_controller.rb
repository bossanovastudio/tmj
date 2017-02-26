class Api::GeneralController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]

  def all
    pagination = pagination_params

    @highlight = Highlight.ordered_by_index.published.page(pagination[:page]).per(1).first

    @cards = Card.page(pagination[:page]).per(pagination[:quantity].to_i - 1).for_home.ordered

    if request.headers['X-Extra-card'].to_i >= 1
      @card = Card.find_by_id(request.headers['X-Extra-card'])

      @cards = [@card] + @cards.where("id != ?", @card.id)
    end

  end

  def highlights
    @highlights = Highlight.published
  end

  def all_without_editors
    pagination = pagination_params
    @cards = Card.left_joins(:user).where({ users: { role: [1, nil] }}).for_home.ordered
    @cards_paginated = @cards.page(pagination[:page]).per(pagination[:quantity].to_i - 1)

    if request.headers['X-Extra-card'].to_i >= 1
      @card = Card.find_by_id(request.headers['X-Extra-card'])

      @cards_paginated = [@card] + @cards_paginated.where("cards.id != ?", @card.id)
    end
  end

  def editors
    pagination = pagination_params
    @user = User.editors.find_by(username: params[:username])
    @cards = []
    @cards = Card.for_editor(@user.username).page(pagination[:page]).per(pagination[:quantity].to_i - 1).ordered unless @user.nil?
  end

  def users
    pagination = pagination_params

    @user = User.find_by!(username: params[:username])
    @cards = @user.cards
    if @user.editor?
      @cards = @cards.for_editor(@user.username)
    else
      @cards = @cards.for_madebyyou.or(@cards.for_home)
    end
    @total_cards = @cards.count
    @cards = @cards.page(pagination[:page]).per(pagination[:quantity].to_i - 1).ordered
  end

  def liked
    @user = User.find_by!(username: params[:username])
    @cards = @user.liked_cards
  end

  def recommended
    pagination = pagination_params

    user = User.find_by!(username: params[:username])
    editor = User.find_by!(username: params[:editor])

    @cards = user.cards.where(id: editor.liked_cards_ids).page(pagination[:page]).per(pagination[:quantity].to_i - 1)
    @cards = @cards.for_madebyyou.or(@cards.for_home).ordered
  end

  def made_by_you
    pagination = pagination_params

    @cards = Card.page(pagination[:page]).per(pagination[:quantity].to_i - 1).for_madebyyou.ordered

  end

  def profile
    @user = User.find_by!(username: params[:username])
  end

  def follow
    user = User.find_by!(username: params[:username])
    current_user.follow user
  end

  def unfollow
    user = User.find_by!(username: params[:username])
    current_user.stop_following user
  end

  private
    def pagination_params
      params.permit(:page, :quantity)
    end
end
