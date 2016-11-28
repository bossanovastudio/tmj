require 'test_helper'

class CastingsControllerTest < ActionDispatch::IntegrationTest
  def casting
    @casting ||= castings :one
  end

  def test_index
    get castings_url
    assert_response :success
  end

  def test_create
    assert_difference('Casting.count') do
      post castings_url, params: { casting: { accept_terms: casting.accept_terms, adult_address: casting.adult_address, adult_birthdate: casting.adult_birthdate, adult_cellphone: casting.adult_cellphone, adult_city: casting.adult_city, adult_document_cpf: casting.adult_document_cpf, adult_document_rg: casting.adult_document_rg, adult_email: casting.adult_email, adult_name: casting.adult_name, adult_neighborhood: casting.adult_neighborhood, adult_phone: casting.adult_phone, adult_state: casting.adult_state, adult_zip: casting.adult_zip, age: casting.age, birthdate: casting.birthdate, document_cpf: casting.document_cpf, document_rg: casting.document_rg, eye_color: casting.eye_color, hair_color: casting.hair_color, height: casting.height, instrument: casting.instrument, instrument_description: casting.instrument_description, name: casting.name, pants_size: casting.pants_size, performance: casting.performance, performance_description: casting.performance_description, photo_body: casting.photo_body, photo_face: casting.photo_face, photo_upperbory: casting.photo_upperbory, shirt_size: casting.shirt_size, shoe_size: casting.shoe_size, singer: casting.singer, skin_color: casting.skin_color, sport: casting.sport, sport_description: casting.sport_description, theater: casting.theater, theater_description: casting.theater_description, video: casting.video, videopassword: casting.videopassword, weight: casting.weight } }
    end

    assert_response 201
  end

  def test_show
    get casting_url(casting)
    assert_response :success
  end

  def test_update
    patch casting_url(casting), params: { casting: { accept_terms: casting.accept_terms, adult_address: casting.adult_address, adult_birthdate: casting.adult_birthdate, adult_cellphone: casting.adult_cellphone, adult_city: casting.adult_city, adult_document_cpf: casting.adult_document_cpf, adult_document_rg: casting.adult_document_rg, adult_email: casting.adult_email, adult_name: casting.adult_name, adult_neighborhood: casting.adult_neighborhood, adult_phone: casting.adult_phone, adult_state: casting.adult_state, adult_zip: casting.adult_zip, age: casting.age, birthdate: casting.birthdate, document_cpf: casting.document_cpf, document_rg: casting.document_rg, eye_color: casting.eye_color, hair_color: casting.hair_color, height: casting.height, instrument: casting.instrument, instrument_description: casting.instrument_description, name: casting.name, pants_size: casting.pants_size, performance: casting.performance, performance_description: casting.performance_description, photo_body: casting.photo_body, photo_face: casting.photo_face, photo_upperbory: casting.photo_upperbory, shirt_size: casting.shirt_size, shoe_size: casting.shoe_size, singer: casting.singer, skin_color: casting.skin_color, sport: casting.sport, sport_description: casting.sport_description, theater: casting.theater, theater_description: casting.theater_description, video: casting.video, videopassword: casting.videopassword, weight: casting.weight } }
    assert_response 200
  end

  def test_destroy
    assert_difference('Casting.count', -1) do
      delete casting_url(casting)
    end

    assert_response 204
  end
end
