if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: Rails.application.credentials.aws[:key_id],
      aws_secret_access_key: Rails.application.credentials.aws[:access_key],
      region: 'us-east-1',
      path_style: true
    }
    config.storage = :fog
    config.fog_directory = Rails.application.credentials.aws[:bucket]
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
        "#{Rails.root}/spec/support/uploads/test/tmp"
      end
 
      def store_dir
        "#{Rails.root}/spec/support/uploads/test/"
      end
    end
  end
end
