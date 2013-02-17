CarrierWave.configure do |config|

  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'carrierwave'

    config.storage = :s3
    config.s3_access_key_id = ENV['S3_KEY']
    config.s3_secret_access_key = ENV['S3_SECRET']
    config.s3_bucket = ENV['S3_BUCKET']
  else
    config.storage = :file
  end
end

require 'carrierwave'
#require 'rmagick'

class Uploader < CarrierWave::Uploader::Base

  #include CarrierWave::RMagick
  #version :thumb do
  #  process :resize_to_fill => [200,200]
  #end

  storage :fog
end
