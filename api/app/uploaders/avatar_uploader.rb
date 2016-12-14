class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog
  process convert: 'png'

  def store_dir
    "avatars/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    ActionController::Base.helpers.image_path "site/profile_default.svg"
  end

  def filename
    "#{secure_token}.png" if original_filename.present?
  end

  def to_base64
    Base64.encode64(open(url) { |io| io.read  }) if url
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
