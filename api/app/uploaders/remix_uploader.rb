class RemixUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    "remix/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
