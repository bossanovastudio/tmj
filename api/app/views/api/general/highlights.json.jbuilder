json.highlights @highlights do |highlight|
  json.partial! "api/highlights/highlight", highlight: highlight
end
