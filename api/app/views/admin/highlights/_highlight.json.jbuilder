json.id         highlight.id
json.content    highlight.content
json.kind       'featured'
json.size       highlight.size
json.source_url highlight.source_url

if highlight.desktop_image
    json.url highlight.desktop_image.file.url
end

if highlight.mobile_image
    json.mobile_url highlight.mobile_image.file.url
end

json.posted_at  highlight.posted_at
json.index      highlight.index
