json.id                     @user.id
json.username               @user.username
json.email                  @user.email
json.bio                    @user.bio
json.image                  @user.image.url
json.followers              @user.followers_count if @user.editor?
json.following              current_user.following? @user if @user.editor? && user_signed_in?
json.ramona_recommendations (@user.cards.pluck(:id) & User.find_by(username: 'ramona').likes.pluck(:id)).count unless User.find_by(username: 'ramona').nil?

json.providers @user.providers do |provider|
  json.name     provider.provider
  json.uid      provider.uid
  json.username provider.username
end

if @user.editor?
    json.editor_color                     @user.editor_color
    json.editor_icon                      @user.editor_icon_url
    json.editor_desktop_background        @user.editor_desktop_background_url
    json.editor_mobile_background         @user.editor_mobile_background_url
    json.editor_menu_background           @user.editor_menu_background_url
    json.editor_recommendation_ribbon     @user.editor_recommendation_ribbon_url
    json.editor_avatar_hover              @user.editor_avatar_hover_url
    json.editor_networks                  @user.editor_networks do |net|
        json.kind net.kind
        json.url  net.url
        json.icon asset_url("site/#{net.kind}-profile.svg")
    end
end
