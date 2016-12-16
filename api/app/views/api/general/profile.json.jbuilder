json.id                     @user.id
json.username               @user.username
json.email                  @user.email
json.bio                    @user.bio
json.image                  @user.image.url
json.following              current_user.bookmarks? @user if @user.role === 'editor' && user_signed_in?
json.ramona_recommendations (@user.cards.pluck(:id) & User.find_by(username: 'ramona').likes.pluck(:id)).count unless User.find_by(username: 'ramona').nil?

json.providers @user.providers do |provider|
  json.name     provider.provider
  json.uid      provider.uid
  json.username provider.username
end
