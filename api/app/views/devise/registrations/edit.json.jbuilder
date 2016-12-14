json.id       current_user.id
json.username current_user.username
json.email    current_user.email
json.bio      current_user.bio
json.image    current_user.image.url

json.providers current_user.providers do |provider|
  json.name provider.provider
  json.uid  provider.uid
end
