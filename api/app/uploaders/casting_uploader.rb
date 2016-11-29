class CastingUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog
  process convert: 'png'

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
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
