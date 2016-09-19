require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  def image
    @image ||= images :one
  end

  def test_index
    get images_url
    assert_response :success
  end

  def test_create
    assert_difference('Image.count') do
      post images_url, params: { image: { file: image.file } }
    end

    assert_response 201
  end

  def test_show
    get image_url(image)
    assert_response :success
  end

  def test_update
    patch image_url(image), params: { image: { file: image.file } }
    assert_response 200
  end

  def test_destroy
    assert_difference('Image.count', -1) do
      delete image_url(image)
    end

    assert_response 204
  end
end
