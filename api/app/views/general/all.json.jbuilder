json.highlights @highlights do |highlight|
  json.partial! "highlights/highlight", highlight: highlight
end

json.cards @cards do |card|
  json.partial! "cards/card", card: card
end
