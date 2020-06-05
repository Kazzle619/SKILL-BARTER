# ファイルに日本語を使えるように
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1'
    }
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'skill-barter-bucket'
    config.asset_host = "https://s3-ap-northeast-1.amazonaws.com/skill-barter-bucket"
    config.cache_storage = :fog
    config.fog_public = true
  end
end
