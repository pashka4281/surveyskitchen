require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "505950646543.apps.googleusercontent.com", "saOIDCYHVKyiieC0tyfik0Wv"
  # importer :yahoo, "consumer_id", "consumer_secret", {:callback_path => '/callback'}
  # importer :hotmail, "client_id", "client_secret"
  # importer :facebook, "client_id", "client_secret"
end