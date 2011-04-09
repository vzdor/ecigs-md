Dir["#{Rails.root}/config/configatron/*.yml"].each do |cfg|
  configatron.configure_from_yaml(cfg)
end

unless (smtp_settings = configatron.smtp_settings).nil?
  Ecigs::Application.configure do
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = smtp_settings
  end
end
