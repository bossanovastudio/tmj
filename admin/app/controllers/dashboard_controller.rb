class DashboardController < ApplicationController
  def index
    @cards = Card.all
  end
end
