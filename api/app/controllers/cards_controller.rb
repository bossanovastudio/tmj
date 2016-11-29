class CardsController < ApplicationController
  before_action :set_card, only: [:show, :like, :unlike, :update, :destroy, :accept, :reject]
  before_action :authenticate_user!, only: [:like, :unlike]
  # before_action :authenticate_admin!, only: [:index, :show, :accept, :reject, :create, :update, :destroy]

  # GET /cards
  # GET /cards.json
  def index
    pagination = pagination_params
    filter = params[:filter]

    @cards = Card.filter_query(filter).page(pagination[:page]).per(pagination[:quantity]).ordered
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/1/like
  # GET /cards/1/like.json
  def like
    liked = current_user.like(@card)

    render :show, status: :ok, location: @card
end

  # GET /cards/1/unlike
  # GET /cards/1/unlike.json
  def unlike
    unliked = current_user.unlike(@card)

    render :show, status: :ok, location: @card
  end

  # POST /cards/1/accept
  # POST /cards/1/accept.json
  def accept
    unless @card.nil?
      @card.update_attribute(:status, :accepted)
      render json: @card
    end
  end

  # POST /cards/1/reject
  # POST /cards/1/reject.json
  def reject
    unless @card.nil?
      @card.update_attribute(:status, :rejected)
      render json: @card
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
  
  # GET /cards/total
  # GET /cards/total.json
  def total
    filter = params[:filter]
    
    @total_cards = Card.filter_query(filter).count
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
      params.require(:card).permit(:user_id, :origin, :source_url, :content, :media_id, :media_type, :posted_at, :social_user => [:id, :username])
    end
end
