json.cards @cards do |card|
  json.partial! "api/cards/card", card: card
end
