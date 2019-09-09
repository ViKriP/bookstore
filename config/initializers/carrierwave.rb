CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET'],
      region: 'us-east-1',
      path_style: true
    }
    config.storage = :fog
    config.fog_directory = ENV['S3_BUCKET']
  end
end

if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
 
  ImageUploader
 
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end
 
      def store_dir
        "#{Rails.root}/spec/support/uploads/"
      end
    end
  end
end
