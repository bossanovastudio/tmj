class MaskUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :fog

  def store_dir
    "avatars/#{model.id}/mask"
  end

  def extension_whitelist
    %w(png)
  end
end
