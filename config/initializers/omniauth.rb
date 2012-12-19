OAUTH_TOKENS = YAML.load_file(Rails.root.join('config', 'oauth_keys.yml'))

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, OAUTH_TOKENS['twitter'][Rails.env]['key'], OAUTH_TOKENS['twitter'][Rails.env]['secret'], 
  	client_options: {ssl: {ca_path: "/etc/ssl/certs"}}
  provider :facebook, OAUTH_TOKENS['facebook'][Rails.env]['key'], OAUTH_TOKENS['facebook'][Rails.env]['secret'], 
  	client_options: {ssl: {ca_path: "/etc/ssl/certs"}}
end