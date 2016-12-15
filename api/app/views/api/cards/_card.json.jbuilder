json.id                     card.id
json.origin                 card.origin
json.content                card.content
json.kind                   card.kind
json.source_url             card.source_url
json.likes                  card.liked_by_count
json.liked                  current_user.likes?(card) if current_user
json.recommended_by_ramona  User.find_by(username: 'ramona').likes?(card)

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
    json.id       card.user.id
    json.username card.user.username
    json.name     card.user.username
    json.role     card.user.role
    json.avatar   card.user.image.url
    json.mask     card.user.mask.url
  end
elsif card.social_user
  json.user do
    json.id     card.social_user.fetch('id', '') 
    json.name   card.social_user.fetch('username', '')
    json.role   :user
  end
end

json.status     card.status
json.posted_at  card.posted_at
