class CastingsController < ApplicationController  
  # POST /castings
  # POST /castings.json
  def create
    @casting = Casting.new(casting_params)

    if @casting.save
      CastingMailer.register_successful(@casting).deliver_later
      
      render :show, status: :created
    else
      render json: @casting.errors, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def casting_params
      the_params = params.permit(:accept_terms, :adult_address, :adult_birthdate, :adult_cellphone, :adult_city, :adult_document_cpf, :adult_document_rg, :adult_email, :adult_name, :adult_neighborhood, :adult_phone, :adult_state, :adult_zip, :age, :birthdate, :document_cpf, :document_rg, :eye_color, :hair_color, :height, :instrument, :instrument_description, :name, :pants_size, :performance, :performance_description, :photo_face, :photo_body, :photo_upperbody, :shirt_size, :shoe_size, :singer, :skin_color, :sport, :sport_description, :theater, :theater_description, :video, :videopassword, :weight)
      the_params[:photo_face] = change_img_params(the_params[:photo_face]) unless the_params[:photo_face].nil?
      the_params[:photo_body] = change_img_params(the_params[:photo_body]) unless the_params[:photo_body].nil?
      the_params[:photo_upperbody] = change_img_params(the_params[:photo_upperbody]) unless the_params[:photo_upperbody].nil?
      the_params
    end
    
    def change_img_params(img)
      begin
        Base64.decode64(img) #To check if thats a base64 string
        if img
          img = file_decode(img.split(',')[1],"") 
        end
      rescue Exception => e
        img
      end
    end
    
    def file_decode(base, filename)
      file = Tempfile.new([file_base_name(filename), file_extn_name(filename)])
      file.binmode
      file.write(Base64.decode64(base))
      file.close
      file
    end

    def file_base_name(file_name)
      File.basename(file_name, file_extn_name(file_name))
    end

    def file_extn_name(file_name)
      File.extname(file_name)
  end
end
