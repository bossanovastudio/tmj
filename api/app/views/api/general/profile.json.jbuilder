json.id                     @user.id
json.username               @user.username
json.email                  @user.email
json.bio                    @user.bio
json.image                  @user.image.url
json.ramona_recommendations @user.cards.pluck(:id) & User.find_by(username: 'ramona').likes.pluck(:id) unless User.find_by(username: 'ramona').nil?

json.providers @user.providers do |provider|
  json.name provider.provider
  json.uid  provider.uid
end
