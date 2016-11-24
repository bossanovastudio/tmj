json.cards @highlights do |highlight|
  json.partial! "highlights/highlight", highlight: highlight
end
