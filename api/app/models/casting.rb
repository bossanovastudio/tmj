# == Schema Information
#
# Table name: castings
#
#  id                      :integer          not null, primary key
#  accept_terms            :boolean
#  adult_address           :string
#  adult_birthdate         :string
#  adult_cellphone         :string
#  adult_city              :string
#  adult_document_cpf      :string
#  adult_document_rg       :string
#  adult_email             :string
#  adult_name              :string
#  adult_neighborhood      :string
#  adult_phone             :string
#  adult_state             :string
#  adult_zip               :string
#  age                     :string
#  birthdate               :string
#  document_cpf            :string
#  document_rg             :string
#  eye_color               :string
#  hair_color              :string
#  height                  :string
#  instrument              :boolean
#  instrument_description  :string
#  name                    :string
#  pants_size              :string
#  performance             :boolean
#  performance_description :string
#  photo_face              :string
#  photo_body              :string
#  photo_upperbody         :string
#  shirt_size              :string
#  shoe_size               :string
#  singer                  :boolean
#  skin_color              :string
#  sport                   :boolean
#  sport_description       :string
#  theater                 :boolean
#  theater_description     :string
#  video                   :string
#  videopassword           :string
#  weight                  :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  newsletter              :boolean
#

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
  validates :adult_state, presence: true
  validates :adult_zip, presence: true
  validates :age, presence: true
  validates :birthdate, presence: true
  validates :eye_color, presence: true
  validates :hair_color, presence: true
  validates :instrument_description, presence: true, if: :instrument?
  validates :name, presence: true
  validates :performance_description, presence: true, if: :performance?
  validates :photo_face, presence: true
  validates :photo_body, presence: true
  validates :photo_upperbody, presence: true
  validates :skin_color, presence: true
  validates :sport_description, presence: true, if: :sport?
  validates :theater_description, presence: true, if: :theater?
  validates :video, presence: true
  
  # Uploader
  mount_uploader :photo_face, CastingUploader
  mount_uploader :photo_body, CastingUploader
  mount_uploader :photo_upperbody, CastingUploader
end
