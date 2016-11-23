json.id         card.id
json.origin     card.origin
json.content    card.content
json.kind       card.kind
json.source_url card.source_url

if card.media
  if card.kind == :image
    json.image do
      json.url    card.media.file.url
      json.width  card.media.width
      json.height card.media.height
      json.ratio  number_with_precision(card.media.ratio, precision: 3)
    end
  elsif card.kind == :video
    json.video do
      json.thumbnail  card.media.thumbnail.url
      json.url        card.media.url
      json.origin     card.media.origin
    end
  end
end

if card.user
  json.user do
    json.id     card.user.id
    json.name   card.user.name
    json.avatar card.user.avatar.url
  end
end

json.status     card.status
json.posted_at  card.posted_at