json.id         highlight.id
json.content    highlight.content
json.source_url highlight.source_url

if highlight.media
  json.image do
    json.url    highlight.media.file.url
    json.width  highlight.media.width
    json.height highlight.media.height
    json.ratio  number_with_precision(highlight.media.ratio, precision: 3)
  end
end

json.posted_at  highlight.posted_at