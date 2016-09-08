require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  def card
    @card ||= cards :one
  end

  def test_index
    get cards_url
    assert_response :success
  end

  def test_create
    assert_difference('Card.count') do
      post cards_url, params: { card: { content: card.content, media_id: card.media_id, media_type: card.media_type, origin: card.origin, posted_at: card.posted_at, user_id: card.user_id } }
    end

    assert_response 201
  end

  def test_show
    get card_url(card)
    assert_response :success
  end

  def test_update
    patch card_url(card), params: { card: { content: card.content, media_id: card.media_id, media_type: card.media_type, origin: card.origin, posted_at: card.posted_at, user_id: card.user_id } }
    assert_response 200
  end

  def test_destroy
    assert_difference('Card.count', -1) do
      delete card_url(card)
    end

    assert_response 204
  end
end
