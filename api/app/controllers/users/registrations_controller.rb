class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :json
  def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        bypass_sign_in resource, scope: resource_name
        respond_with resource, location: after_update_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
  end

  protected
    def update_resource(resource, params)
      resource.update_without_password(params)
    end
    
    def account_update_params
      the_params = params.require(:user).permit(:bio, :password, :email, :image, :username)
      the_params[:image] = change_img_params(the_params[:image]) unless the_params[:image].nil?
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
