class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :account_name, :invited, :full_name

#associations:
  has_many :surveys
  has_one :owned_account, :foreign_key => :owner_id, class_name: 'Account'
  belongs_to :account
  has_many :authentications, dependent: :destroy

#validations:
  # validates :account_name, presence: true, length: {minimum: 6}, on: :create
  # validate :unique_account
  validates_presence_of :password, on: :create
  validates_presence_of :first_name, :last_name, :if => lambda{|x| x.full_name.blank? }

  attr_accessor :account_name, :invited, :from_external_provider

  after_create :setup_account
  before_save :set_full_name

  def facebook_auth
    authentications.facebook.first
  end

  def twitter_auth
    authentications.twitter.first
  end

#private methods:
  private

  def set_full_name
    self.full_name = [first_name, last_name].join(' ') if self.full_name.blank?
  end

  def setup_account
    unless self.invited
      a = Account.create(name: self.account_name, owner: self)
      a.users << self
    end
  end

  def unique_account
    errors.add(:base, "Such account name is already taken, select another one") if Account.find_by_name(account_name)
  end
end
