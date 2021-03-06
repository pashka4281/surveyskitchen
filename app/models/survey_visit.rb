class SurveyVisit < ActiveRecord::Base
  attr_accessible :survey_id, :user_agent_string, :content, :remote_ip, :response_data
  belongs_to :survey
  
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

  def geodata
    GeoTools.get_info_by_ip self.remote_ip
  end

  def completeness
    
  end

  private

  def write_property(field_name, val)
    self.content = self.content.merge({field_name => val})
  end

  def read_property(field_name)
    self.content[field_name]
  end
end
