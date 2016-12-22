class Admin::CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]
  # before_action :authenticate_admin!, only: [:index, :show, :accept, :reject, :create, :update, :destroy]

  # GET /cards
  # GET /cards.json
  def index
    pagination = pagination_params
    filter = filter_params

    @cards = Card.filter_query(filter).page(pagination[:page]).per(pagination[:quantity]).ordered
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # POST /cards/accept
  def accept
    @cards = Card.find(bulk_params[:id])

    @cards.each do |card|
      card.update_attribute(:status, :accepted)
    end

    redirect_to :back
  end

  # POST /cards/reject
  def reject
    @cards = Card.find(bulk_params[:id])

    @cards.each do |card|
      card.update_attribute(:status, :rejected)
    end

    redirect_to :back
  end

  # POST /cards
  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to @card, notice: 'Card was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      redirect_to @card, notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
    redirect_to cards_url, notice: 'Card was successfully destroyed.'
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

    def filter_params
      params.permit(:origin, :status, :search, 'providers.user_id')
    end

    def bulk_params
      params.require(:card).permit(:id => [])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:user_id, :origin, :source_url, :content, :media_id, :media_type, :posted_at, :social_uid, :social_user => [:id, :username])
    end
end
