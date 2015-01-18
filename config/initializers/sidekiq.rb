Sidekiq.configure_server do |config|
  config.redis = { url: ENV['PIXIU_REDIS_PROVIDER'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['PIXIU_REDIS_PROVIDER'] }
end