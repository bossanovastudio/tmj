class Admin::ModeratorController < Admin::AdminController

  def home_admin
    @page_title = "Home"
    filtered_cards(:home) { Card.all }
  end

  def madebyyou_admin
    @page_title = "Feito Por Você"
    filtered_cards(:madebyyou) { Card.where.not(remix_image_id: nil) }
  end

  def character_admin
    user = User.find_by!(username: params[:username])
    @page_title = user.username
    filtered_cards(:characters, user.username.to_sym) { user.cards }
  end

  def accept
    moderate_incoming_cards(true)
    redirect_to :back
  end

  def reject
    moderate_incoming_cards(false)
    redirect_to :back
  end

  private

    def filtered_cards(*page_params)
      pagination = pagination_params
      filter = filter_params
      @cards = yield
      if !filter.empty? && filter.key?(:status) && !filter[:status].empty?
        @cards = @cards.with_status(filter[:status], *page_params)
      end
      @cards = @cards.filter_query(filter.except(:status)).page(pagination[:page]).per(pagination[:quantity]).ordered
      @moderation_page_id = page_params.last
    end

    def moderate_incoming_cards(how)
      @cards = Card.find(bulk_params[:id])
      relative = params[:relative_to]
      sel = case relative
      when "home", "madebyyou"
        "moderate_for_#{relative}"
      else
        "moderate_for_editor"
      end

      @cards.each do |card|
        if sel == "moderate_for_editor"
          card.send(sel, relative, how)
        else
          card.send(sel, how)
        end
        card.save
      end
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
end
