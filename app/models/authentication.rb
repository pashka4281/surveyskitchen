class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :user, :linked_name, :access_token, :access_token_secret, :account_url
  
  belongs_to :user
  
  scope :facebook, where(provider: 'facebook')
  scope :twitter,  where(provider: 'twitter')

  def self.create_from_oauth(auth_h, user, provider)
  	self.create(
	  	linked_name: auth_h.extra.raw_info.name,
  		access_token: auth_h.credentials.token,
  		access_token_secret: auth_h.credentials.secret,
  		provider: provider,
  		uid: auth_h.uid,
  		user: user)
  end
end
