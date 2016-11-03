json.id         card.id
json.origin     card.origin
json.content    card.content
json.media      card.media

json.user card.user do |user|
  json.id     user.id
  json.name   user.name
end

json.posted_at  card.posted_at