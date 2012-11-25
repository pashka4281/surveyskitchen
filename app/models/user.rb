class User < ActiveRecord::Base

  has_secure_password

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :account_name

  has_many :surveys
  has_one :owned_account, :foreign_key => :owner_id, class_name: 'Account'
  belongs_to :account

  validates :account_name, presence: true, length: {minimum: 6}, on: :create
  validate :unique_account
  validates_presence_of :password, on: :create

  attr_accessor :account_name

  after_create :setup_account
  before_save :set_full_name

  private

  def set_full_name
    self.full_name = [first_name, last_name].join(' ')
  end

  def setup_account
    unless self.invited?
      a = Account.create(name: self.account_name, owner: self)
      a.users << self
    end
  end

  def unique_account
    errors.add(:base, "Such account name is already taken, select another one") if Account.find_by_name(account_name)
  end
end
