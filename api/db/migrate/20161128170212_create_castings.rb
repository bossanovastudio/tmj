class CreateCastings < ActiveRecord::Migration[5.0]
  def change
    create_table :castings do |t|
      t.boolean :accept_terms
      t.string :adult_address
      t.string :adult_birthdate
      t.string :adult_cellphone
      t.string :adult_city
      t.string :adult_document_cpf
      t.string :adult_document_rg
      t.string :adult_email
      t.string :adult_name
      t.string :adult_neighborhood
      t.string :adult_phone
      t.string :adult_state
      t.string :adult_zip
      t.string :age
      t.string :birthdate
      t.string :document_cpf
      t.string :document_rg
      t.string :eye_color
      t.string :hair_color
      t.string :height
      t.boolean :instrument
      t.string :instrument_description
      t.string :name
      t.string :pants_size
      t.boolean :performance
      t.string :performance_description
      t.string :photo_face
      t.string :photo_body
      t.string :photo_upperbody
      t.string :shirt_size
      t.string :shoe_size
      t.boolean :singer
      t.string :skin_color
      t.boolean :sport
      t.string :sport_description
      t.boolean :theater
      t.string :theater_description
      t.string :video
      t.string :videopassword
      t.string :weight

      t.timestamps
    end
  end
end
