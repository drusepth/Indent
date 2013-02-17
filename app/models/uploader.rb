require 'carrierwave'
#require 'rmagick'

class Uploader < CarrierWave::Uploader::Base

  #include CarrierWave::RMagick
  #version :thumb do
  #  process :resize_to_fill => [200,200]
  #end

  storage :fog
end
