class GeneralController < ApplicationController
  def all
    pagination = pagination_params

    @highlight = Highlight.page(pagination[:page]).per(1).first
    @cards = Card.page(pagination[:page]).per(pagination[:quantity].to_i - 1).approved.ordered
  end

  def highlights
    @highlights = Highlight.all
  end

  def editors
    pagination = pagination_params
    
    @user = User.editors.where(username: params[:id]).first
    @cards = @user.cards.page(pagination[:page]).per(pagination[:quantity].to_i - 1).approved.ordered
  end

  private
    def pagination_params
      params.permit(:page, :quantity)
    end
end
