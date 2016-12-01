json.id         highlight.id
json.content    highlight.content
json.kind       'featured'
json.size       highlight.size

if highlight.media
  json.url    highlight.media.file.url
end

if highlight.mobile_media
    json.mobile_url    highlight.mobile_media.file.url
end

json.posted_at  highlight.posted_at
json.index      highlight.index
