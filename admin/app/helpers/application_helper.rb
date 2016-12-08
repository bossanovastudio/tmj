module ApplicationHelper
  def paginate(actual=nil)
    total_cards = Card.get(:total, filter: { origin: params[:origin], status: params[:status], content: params[:content] })['cards']
    quantity = (params[:quantity].nil? && 20) || params[:quantity]
    page = (params[:page].nil? && 1) || params[:page].to_i
    pages = (total_cards.to_f / quantity.to_f).ceil

    html = "<ul class='pagination'>"

    pages_range = 1..pages
    visible_pages = calculate_visible_range(page, pages_range)
    elipsis = '<li class="separator"><span>...</span></li>'.html_safe

    # Inject first page if not visible
    html += link_to_pagination_page(pages_range.first, page, quantity) unless visible_pages.include? pages_range.first
    html += elipsis if page > 3
    html += visible_pages.collect { |n| link_to_pagination_page(n, page, quantity) }.join('').html_safe
    # html += elipsis if
    # Inject first page if not visible
    html += elipsis if pages - visible_pages.last > 1
    html += link_to_pagination_page(pages_range.last, page, quantity) unless visible_pages.include? pages_range.last
    html += "</ul>"
    html.html_safe
  end

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
    permitted_params = [:origin, :status, :content]
    active_params = params.permit(*permitted_params).to_h.slice(*permitted_params)

    active_params[key] = value if permitted_params.include? key

    '?'+ active_params.to_query
  end

  def card_size(card)
    if card.kind == 'video'
      "two-five"
    elsif card.kind == 'image'
      if card.image.ratio.to_f <= 1.0
        "one-five"
      else
        percent = 50 * (card.image.height / card.image.width)
        if percent > 16
          "two-five"
        else
          "one-five"
        end
      end
    else
      "one-five"
    end
  end

  def card_image_size(card)
    ratio = card.image.ratio.gsub(',', '.').to_f

    if ratio <= 1.0
      percent = 50.0 * (1.0 + (1.0 - ratio))
    else
      percent = 50.0 * (card.image.height.to_f / card.image.width.to_f)
    end
  end

  def youtube_id(url)
    url.match(/(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/ ]{11})/i)[1]
  end

  def active_class(path)
    request.path =~ /#{path}/ ? 'active' : nil
  end
end
