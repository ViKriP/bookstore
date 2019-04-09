class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  process resize_to_fit: [500, 500]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    '/assets/' + [version_name, 'default.jpg'].compact.join('_')
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
