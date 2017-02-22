json.id                     card.id
json.origin                 card.origin
json.content                card.content
if card.is_from_remix?
  json.kind                   :image
else
  json.kind                   card.kind
end
json.source_url             card.source_url
json.likes                  card.liked_by_count
json.liked                  current_user.likes?(card) if user_signed_in?

if card.recommended_by_editor?
  json.recommended_by do
    json.editor_color             card.first_recommended_by.editor_color
    json.editor_ribbon            card.first_recommended_by.editor_recommendation_ribbon_url
    json.editor_ribbon_animated   card.first_recommended_by.editor_recommendation_ribbon_animated_url
    json.editor_username          card.first_recommended_by.username
  end
end

# json.recommended_by        card.liked_by.where(role: :editor).first

 # json.recommended_by_ramona  User.find_by(username: 'ramona').likes?(card) if User.find_by(username: 'ramona')

json.is_from_remix          card.is_from_remix?

if card.is_from_remix?
  json.image do
    json.url    card.remix_image.image_url
    json.width  512
    json.height 512
    json.ratio  "1"
  end
else
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
end

if card.user
  json.user do
    json.id       card.user.id
    json.username card.user.username
    json.name     card.user.username
    json.role     card.user.role
    json.avatar   card.user.image.url
    json.mask     card.user.mask.url
    if card.user.editor?
      json.editor_color card.user.editor_color
    end
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
