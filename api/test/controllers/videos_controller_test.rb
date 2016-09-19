require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  def video
    @video ||= videos :one
  end

  def test_index
    get videos_url
    assert_response :success
  end

  def test_create
    assert_difference('Video.count') do
      post videos_url, params: { video: { origin: video.origin, url: video.url } }
    end

    assert_response 201
  end

  def test_show
    get video_url(video)
    assert_response :success
  end

  def test_update
    patch video_url(video), params: { video: { origin: video.origin, url: video.url } }
    assert_response 200
  end

  def test_destroy
    assert_difference('Video.count', -1) do
      delete video_url(video)
    end

    assert_response 204
  end
end
