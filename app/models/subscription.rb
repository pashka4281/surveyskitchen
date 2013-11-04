class Subscription < ActiveRecord::Base
  attr_accessible :account_id, :plan_id, :last_payed_at,
    :plan, :account

  belongs_to :plan
  belongs_to :account

  def expired?
    Date.last_payed_at + 1.month < Date.current
  end
end
