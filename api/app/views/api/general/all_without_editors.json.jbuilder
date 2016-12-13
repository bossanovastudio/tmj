json.total_cards @cards.count

json.cards @cards_paginated do |card|
  json.partial! "api/cards/card", card: card
end
