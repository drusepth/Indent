CarrierWave.configure do |config|

  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = 'carrierwave'

    config.storage = :s3
    config.s3_access_key_id = 'AKIAIWF4IBEMI6EQ3XOA'
    config.s3_secret_access_key = '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'
    config.s3_bucket = 'drusepth_Plan'
  else
    config.storage = :file
  end
end
