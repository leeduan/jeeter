Jeeter::Application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'
  config.log_level = :info
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.action_mailer.default_url_options = {
    host: 'your_domain.com'
  }
  config.action_mailer.smtp_settings = {
    port:                 ENV['SMTP_PORT'],
    address:              ENV['SMTP_SERVER'],
    user_name:            ENV['SMTP_LOGIN'],
    password:             ENV['SMTP_PASSWORD'],
    domain:               'your_domain.com',
    authentication:       :plain,
  }
  config.action_mailer.delivery_method = :smtp
end
