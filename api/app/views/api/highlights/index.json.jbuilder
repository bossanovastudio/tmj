json.cards @highlights do |highlight|
  json.partial! 'api/highlights/highlight', highlight: highlight
end
