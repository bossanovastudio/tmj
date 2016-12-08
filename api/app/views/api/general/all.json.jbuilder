if @highlight
  json.highlight do
    json.partial! "highlights/highlight", highlight: @highlight
  end
end

json.cards @cards do |card|
  json.partial! "cards/card", card: card
end
