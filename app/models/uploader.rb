CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'xxx',
    :aws_secret_access_key  => 'yyy'
  }
  config.fog_directory  = 'zzz'
end

class Uploader
  storage :fog
end
