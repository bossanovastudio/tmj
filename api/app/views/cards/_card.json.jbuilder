json.extract! card, :id, :user_id, :origin, :content, :media_id, :media_type, :posted_at, :created_at, :updated_at
json.url card_url(card, format: :json)