CarrierWave.configure do |config|
  config.permissions = 0600
  config.directory_permissions = 0700
  config.storage = :fog

  # config.fog_credentials = {
  #     provider: 'AWS',
  #     aws_access_key_id: 'xxx',
  #     aws_secret_access_key: 'yyy',
  #     region: 'eu-west-1',
  #     host: 's3.example.com',
  #     endpoint: 'https://s3.example.com:8080'
  # }

  config.fog_credentials = {
      provider: 'Local',
      local_root: "#{Rails.root}/public/fog",
      endpoint: "#{"https://www.#{ENV['PIXIU_DOMAIN']}" if Rails.env.production?}/fog",
  }

  config.fog_directory = 'tmp'
  config.fog_public = true
  config.fog_attributes = {'Cache-Control' => "max-age=#{5.years.to_i}"}
end