json.highlights @highlights do |highlight|
  json.partial! "highlights/highlight", highlight: highlight
end
