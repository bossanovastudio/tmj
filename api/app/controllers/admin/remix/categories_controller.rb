class Admin::Remix::CategoriesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = ::Remix::Category.all
  end

  def new
    @category = ::Remix::Category.new
  end

  def create
    @category = ::Remix::Category.new(category_params)
    if @category.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to action: :index, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to action: :index, notice: 'Category was successfully destroyed.'
  end


  private
    def category_params
      params.require(:remix_category).permit(:name, :cover)
    end

    def set_category
      @category = ::Remix::Category.find(params[:id])
    end
end
