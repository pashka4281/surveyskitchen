class Response < ActiveRecord::Base
  attr_accessible :user_agent_string, :response_data, :remote_ip, :survey, :survey_id

  belongs_to :survey
  serialize :content

  def response_data=(data) #data - survey form data
  	data.each do |key, val|
  		write_property(key.split('-')[-1], val)
  	end
  end

  def content
   	read_attribute(:content) || {}
  end

  def agent
    AgentOrange::UserAgent.new(self.user_agent_string)
  end

  private

  def write_property(field_name, val)
  	self.content = self.content.merge({field_name => val})
  end

  def read_property(field_name)
  	self.content[field_name]
  end
end
