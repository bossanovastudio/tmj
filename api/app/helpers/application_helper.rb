module ApplicationHelper
  def link_to_pagination_page(n, page, quantity)
    link_to paginate_cards_path(n, quantity, status: params[:status], origin: params[:origin]) do
      if n == page
        link = "<li class='active'>"
      else
        link = "<li>"
      end

      link += "<span>#{n}</span>"
      link += "</li>"

      link.html_safe
    end
  end

  def calculate_visible_range(current, range)
    if current > 2
        to_drop = current - 2
        to_drop = range.count - 3 if range.count - to_drop < 3
        range = range.drop(to_drop)
    end
    range = range.take(3) if range.count > 3
    range
  end

  def query_string(key, value)
    permitted_params = [:origin, :status, :content, 'providers.user_id']
    active_params = params.permit(*permitted_params).to_h.slice(*permitted_params)

    active_params[key] = value if permitted_params.include? key

    '?'+ active_params.to_query
  end

  def card_size(card)
    if card.kind == 'video'
      "two-five"
    elsif card.kind == 'image'
      if card.media.ratio.to_f <= 1.0
        "one-five"
      else
        percent = 50 * (card.media.height / card.media.width)
        if percent > 16
          "two-five"
        else
          "one-five"
        end
      end
    elsif card.is_from_remix?
      "two-five"
    else
      "one-five"
    end
  end

  def card_image_size(card)
    ratio = card.media.ratio

    if ratio <= 1.0
      percent = 50.0 * (1.0 + (1.0 - ratio))
    else
      percent = 50.0 * (card.media.height.to_f / card.media.width.to_f)
    end
  end

  def youtube_id(url)
    url.match(/(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})/i)[1]
  end

  def active_class(path)
    request.path =~ /#{path}/ ? 'active' : nil
  end

end
