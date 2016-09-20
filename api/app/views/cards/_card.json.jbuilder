json.extract! card, :id, :user_id, :origin, :content, :media, :posted_at, :created_at, :updated_at
json.url card_url(card, format: :json)