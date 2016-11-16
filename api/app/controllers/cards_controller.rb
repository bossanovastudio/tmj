class CardsController < ApplicationController
  before_action :set_card, only: [:show, :like, :unlike, :update, :destroy]
  before_action :authenticate_user!, only: [:like, :unlike]

  # GET /cards
  # GET /cards.json
  def index
    pagination = pagination_params
    
    @cards = Card.page(pagination[:page]).per(pagination[:quantity])
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/1/like
  # GET /cards/1/like.json
  def like
    if user_signed_in?
      liked = current_user.like(@card)
      
      render :show, status: :ok, location: @card
    end
  end

  # GET /cards/1/unlike
  # GET /cards/1/unlike.json
  def unlike
    if user_signed_in?
      unliked = current_user.unlike(@card)
      
      render :show, status: :ok, location: @card
    end
  end
  
  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    if @card.save
      render :show, status: :created, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    if @card.update(card_params)
      render :show, status: :ok, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    unless @card.destroy
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
      params.require(:card).permit(:user_id, :origin, :source_url, :content, :media_id, :media_type, :posted_at)
    end
end
