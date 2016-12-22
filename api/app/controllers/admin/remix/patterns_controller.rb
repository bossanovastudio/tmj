class Admin::Remix::PatternsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_pattern, only: [:destroy]

  def index
    @patterns = ::Remix::Pattern.all
  end

  def new
    @pattern = ::Remix::Pattern.new
  end

  def create
    @pattern = ::Remix::Pattern.new(pattern_params)
    if @pattern.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    @pattern.destroy
    redirect_to action: :index, notice: 'Pattern was successfully destroyed.'
  end


  private
    def pattern_params
      params.require(:remix_pattern).permit(:image)
    end

    def set_pattern
      @pattern = ::Remix::Pattern.find(params[:id])
    end
end
