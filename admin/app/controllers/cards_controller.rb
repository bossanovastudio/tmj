class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  def index
    @status = params.fetch(:status, nil)
    @cards = Card.find(:all, params: {
        filter: {
            origin: params[:origin],
            status: params[:status],
            content: params[:content],
        },
        page: params[:page],
        quantity: params[:quantity]
    })
  end

  # GET /cards/1
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
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

  # POST /cards/accept
  def accept
    @cards = Card.find(:all, params: { filter: { id: bulk_params[:id] } })

    @cards.each do |card|
      card.get(:accept)
    end
    redirect_to cards_url
  end

  # POST /cards/reject
  def reject
    @cards = Card.find(:all, params: { filter: { id: bulk_params[:id] } })

    @cards.each do |card|
      card.get(:reject)
    end
    redirect_to cards_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.require(:card).permit(:origin, :content, :media_id, :media_type, :posted_at)
    end

    def bulk_params
      params.require(:card).permit(:id => [])
    end
end
