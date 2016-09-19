require "test_helper"

describe CardsController do
  let(:card) { cards :one }

  it "gets index" do
    get cards_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_card_url
    value(response).must_be :success?
  end

  it "creates card" do
    expect {
      post cards_url, params: { card: { content: card.content, media_id: card.media_id, media_type: card.media_type, origin: card.origin, posted_at: card.posted_at } }
    }.must_change "Card.count"

    must_redirect_to card_path(Card.last)
  end

  it "shows card" do
    get card_url(card)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_card_url(card)
    value(response).must_be :success?
  end

  it "updates card" do
    patch card_url(card), params: { card: { content: card.content, media_id: card.media_id, media_type: card.media_type, origin: card.origin, posted_at: card.posted_at } }
    must_redirect_to card_path(card)
  end

  it "destroys card" do
    expect {
      delete card_url(card)
    }.must_change "Card.count", -1

    must_redirect_to cards_path
  end
end
