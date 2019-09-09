require 'rails_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  if Rails.env.production?
    storage :fog
  end

  let(:path_to_file) { "#{fixture_path}/images/default.png" }
  let(:uploader) { ImageUploader.new }

  before do
    ImageUploader.enable_processing = true

    File.open(path_to_file) { |f| uploader.store!(f) }
  end

  after do
    ImageUploader.enable_processing = false

    uploader.remove!
  end

  context 'the thumb version' do
    it 'scales down a landscape image to be exactly 150 by 150 pixels' do
      expect(uploader.thumb).to have_dimensions(150, 150)
    end
  end

  context 'the default_url' do
    it 'has the correct default_url' do
      expect(uploader.default_url).to eql '/assets/default.png'
    end
  end
end
