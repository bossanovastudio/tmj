require "test_helper"

describe HighlightsController do
  let(:highlight) { highlights :one }

  it "gets index" do
    get highlights_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_highlight_url
    value(response).must_be :success?
  end

  it "creates highlight" do
    expect {
      post highlights_url, params: { highlight: { content: highlight.content, media_id: highlight.media_id, media_type: highlight.media_type, posted_at: highlight.posted_at, size: highlight.size, source_url: highlight.source_url } }
    }.must_change "Highlight.count"

    must_redirect_to highlight_path(Highlight.last)
  end

  it "shows highlight" do
    get highlight_url(highlight)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_highlight_url(highlight)
    value(response).must_be :success?
  end

  it "updates highlight" do
    patch highlight_url(highlight), params: { highlight: { content: highlight.content, media_id: highlight.media_id, media_type: highlight.media_type, posted_at: highlight.posted_at, size: highlight.size, source_url: highlight.source_url } }
    must_redirect_to highlight_path(highlight)
  end

  it "destroys highlight" do
    expect {
      delete highlight_url(highlight)
    }.must_change "Highlight.count", -1

    must_redirect_to highlights_path
  end
end
