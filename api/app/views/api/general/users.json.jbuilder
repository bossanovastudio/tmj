json.total_cards @total_cards

json.cards @cards do |card|
  json.partial! "api/cards/card", card: card
end
