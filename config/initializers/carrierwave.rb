CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAIGOJAMRF74TS6ZLQ',
    aws_secret_access_key: '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',
    region:                'us-west-2',
  }
  config.fog_directory  = 'knackmap-dev'
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }

  config.storage = :fog

  # config.storage = :file
  config.asset_host = ActionController::Base.asset_host
end