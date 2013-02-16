class Event < ActiveRecord::Base
  attr_accessible :account_id, :account_id, :eventable

  belongs_to :eventable, polymorphic: true
  belongs_to :account
  validates  :account_id, presence: true
  default_scope order('created_at DESC')

  def message
  	raise NotImplementedError
  	# I18n.t "models.#{eventable_type.downcase}.on_#{event_name}_event", survey_name: eventable.name
  end

  after_create :remove_old_events

  private

  def remove_old_events
  	p self.account.events.first
  	#self.account.events.first.delete if self.account.events.count > 20
  end
end
