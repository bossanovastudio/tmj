class GeneralController < ApplicationController
  def all
    pagination = pagination_params

    @highlight = Highlight.page(pagination[:page]).per(1).first
    @cards = Card.page(pagination[:page]).per(pagination[:quantity].to_i - 1).approved.ordered
  end

  def highlights
    @highlights = Highlight.all
  end

  def all_without_editors
    pagination = pagination_params
    @cards = Card.left_joins(:user).where({ users: { role: [1, nil] }}).approved.ordered
    @cards_paginated = @cards.page(pagination[:page]).per(pagination[:quantity].to_i - 1)
  end

  def editors
    pagination = pagination_params

    @user = User.editors.where(username: params[:id]).first
    @cards = @user.cards.page(pagination[:page]).per(pagination[:quantity].to_i - 1).not_rejected.ordered
  end

  private
    def pagination_params
      params.permit(:page, :quantity)
    end
end
