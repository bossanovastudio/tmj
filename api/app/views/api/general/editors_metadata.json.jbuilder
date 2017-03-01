json.array! @editors.each do |user|
    json.usernamename       user.username
    json.background_mobile       user.editor_mobile_background_url
    json.badge                   user.editor_icon_url
    json.avatar                  user.image_url
    json.like_button             user.like_button_url
    json.like_button_rollover    user.like_button_hover_url
end
