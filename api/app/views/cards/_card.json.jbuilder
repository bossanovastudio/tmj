json.id         card.id
json.origin     card.origin
json.content    card.content
json.kind       card.kind

if card.media
  json.image do
    json.url   card.media.file.url
    json.ratio number_with_precision(card.media.ratio, precision: 3)
  end
end

if card.user
  json.user do
    json.id     card.user.id
    json.name   card.user.name
  end
end

json.posted_at  card.posted_at