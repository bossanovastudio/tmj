class Api::CardsController < ApplicationController
  before_action :set_card, only: [:show, :like, :unlike]
  before_action :authenticate_user!, only: [:like, :unlike]
  # before_action :authenticate_admin!, only: [:index, :show, :accept, :reject, :create, :update, :destroy]

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/1/like
  # GET /cards/1/like.json
  def like
    liked = current_user.like(@card)

    render :show, status: :ok
  end

  # GET /cards/1/unlike
  # GET /cards/1/unlike.json
  def unlike
    unliked = current_user.unlike(@card)

    render :show, status: :ok
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    if @card.save
      render :show, status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    def pagination_params
      params.permit(:page, :quantity)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:user_id, :origin, :source_url, :content, :media_id, :media_type, :posted_at, :social_uid, :remix_image_id, :social_user => [:id, :username])
    end
end
