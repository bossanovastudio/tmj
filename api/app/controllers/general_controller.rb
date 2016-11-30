class GeneralController < ApplicationController
  def all
    pagination = pagination_params
    
    @highlight = Highlight.page(pagination[:page]).per(1).first
    @cards = Card.page(pagination[:page]).per(pagination[:quantity].to_i - 1).approved
  end
  
  def highlights
    @highlights = Highlight.all
  end
  
  def editors
    user = User.editors.where(username: params[:id]).first
    @cards = user.cards
  end
  
  private
    def pagination_params
      params.permit(:page, :quantity)
    end
end
