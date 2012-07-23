class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :first_name, :last_name, :account_name

  attr_accessor :account_name

  has_one :owned_account, :foreign_key => :owner_id, class_name: 'Account'
  belongs_to :account

  after_create :setup_account

  private

  def setup_account
    if !self.account_name.blank? && !self.invited?
      a = Account.create(name: self.account_name, owner: self)
      a.users << self
    end
  end
end
