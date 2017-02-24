class Api::PagesController < ApplicationController
  before_action :load_page

  def index
    render json: @page
  end

  private
    def load_page
      @page = ::Page.find(params[:id])
    end

end
