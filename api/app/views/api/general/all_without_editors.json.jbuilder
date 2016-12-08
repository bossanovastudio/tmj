json.total_cards @cards.count

json.cards @cards_paginated do |card|
  json.partial! "cards/card", card: card
end
