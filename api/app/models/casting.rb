class Casting < ApplicationRecord
  validates :accept_terms, acceptance: true
  validates :adult_address, presence: true
  validates :adult_birthdate, presence: true
  validates :adult_cellphone, presence: true
  validates :adult_city, presence: true
  validates :adult_document_cpf, presence: true
  validates :adult_document_rg, presence: true
  validates :adult_email, presence: true
  validates :adult_name, presence: true
  validates :adult_neighborhood, presence: true
  validates :adult_phone, presence: true
  validates :adult_state, presence: true
  validates :adult_zip, presence: true
  validates :age, presence: true
  validates :birthdate, presence: true
  validates :document_cpf, presence: true
  validates :document_rg, presence: true
  validates :eye_color, presence: true
  validates :hair_color, presence: true
  validates :height, presence: true
  validates :instrument_description, presence: true, if: :instrument?
  validates :name, presence: true
  validates :pants_size, presence: true
  validates :performance_description, presence: true, if: :performance?
  validates :photo_face, presence: true
  validates :photo_body, presence: true
  validates :photo_upperbody, presence: true
  validates :shirt_size, presence: true
  validates :shoe_size, presence: true
  validates :skin_color, presence: true
  validates :sport_description, presence: true, if: :sport?
  validates :theater_description, presence: true, if: :theater?
  validates :video, presence: true
  validates :weight, presence: true
  
  # Uploader
  mount_uploader :photo_face, CastingUploader
  mount_uploader :photo_body, CastingUploader
  mount_uploader :photo_upperbody, CastingUploader
end
