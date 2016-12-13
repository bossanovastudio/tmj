json.total_cards @user.cards.approved.count

json.cards @cards do |card|
  json.partial! "api/cards/card", card: card
end
