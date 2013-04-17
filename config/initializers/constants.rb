APP_HOST = %w(test development).include?(Rails.env) ? 'http://localhost:3000' : 'http://surveyskitchen.com'
SURVEY_REPORT_SETTINGS = YAML.load_file(Rails.root.join('config', 'settings', 'report_settings.yml'))

require 'geoip'

GEO_IP_DATABASE = GeoIP::City.new(Rails.root.join('db', 'GeoLiteCity.dat').to_s) rescue Rails.logger.warn("GeoIp database file not found")

module GeoTools
	def self.get_info_by_ip(ip)
		GEO_IP_DATABASE.look_up(ip)
	end
end

module DbUpdates
def self.migrate_to_new_val
	Response.all.collect(&:content).each{|resp| 
		resp.each{|i_id, val| 
			s= SurveyItem.where("id = #{i_id} and type in('SingleSelectQuestion', 'SurveyItems::MultipleSelectQuestion', 'SurveyItems::DropDown')").first
			if s
				tmp = resp[i_id]
				p resp
				if resp[i_id]['values'].blank?
					resp[i_id] = {'values' => tmp}
					p resp
					s.content = resp
					s.save
				end
			end 
		} 
	}
end
end
