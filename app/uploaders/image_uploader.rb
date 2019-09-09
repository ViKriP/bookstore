class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  if Rails.env.production?
    storage :fog
  end

  process resize_to_fit: [400, 400]

  version :thumb do
    process resize_to_fill: [150, 150]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    '/assets/' + [version_name, 'default.png'].compact.join('_')
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
