json.id         highlight.id
json.content    highlight.content
json.kind       'featured'
json.size       highlight.size

if highlight.media
  json.url    highlight.media.file.url
end

json.posted_at  highlight.posted_at