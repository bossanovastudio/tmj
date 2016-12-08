class Admin::HighlightsController < ApplicationController
  before_action :set_highlight, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:like, :unlike]
  # before_action :authenticate_admin!, only: [:index, :show, :create, :update, :destroy]

  # GET /highlights
  # GET /highlights.json
  def index
    pagination = pagination_params
    
    @highlights = Highlight.page(pagination[:page]).per(pagination[:quantity])
  end

  # GET /highlights/1
  # GET /highlights/1.json
  def show
  end
  
  # POST /highlights
  # POST /highlights.json
  def create
    @highlight = Highlight.new(highlight_params)

    if @highlight.save
      render :show, status: :created, location: @highlight
    else
      render json: @highlight.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /highlights/1
  # PATCH/PUT /highlights/1.json
  def update
    if @highlight.update(highlight_params)
      render :show, status: :ok, location: @highlight
    else
      render json: @highlight.errors, status: :unprocessable_entity
    end
  end

  # DELETE /highlights/1
  # DELETE /highlights/1.json
  def destroy
    unless @highlight.destroy
      render json: @highlight.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_highlight
      @highlight = Highlight.find(params[:id])
    end
    
    def pagination_params
      params.permit(:page, :quantity)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def highlight_params
      params.require(:highlight).permit(:origin, :source_url, :content, :media_id, :media_type, :posted_at)
    end
end
