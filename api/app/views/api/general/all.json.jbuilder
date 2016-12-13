if @highlight
  json.highlight do
    json.partial! "api/highlights/highlight", highlight: @highlight
  end
end

json.cards @cards do |card|
  json.partial! "api/cards/card", card: card
end
