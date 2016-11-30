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

require "test_helper"

class CastingTest < ActiveSupport::TestCase
  def casting
    @casting ||= Casting.new
  end

  def test_valid
    assert casting.valid?
  end
end
