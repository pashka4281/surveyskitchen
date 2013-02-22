APP_HOST = %w(test development).include?(Rails.env) ? 'http://localhost:3000' : 'http://surveyskitchen.com'

require 'geoip'

GEO_IP_DATABASE = GeoIP::City.new(Rails.root.join('db', 'GeoLiteCity.dat').to_s) rescue Rails.logger.warn("GeoIp database file not found")

module GeoTools
	def self.get_info_by_ip(ip)
		GEO_IP_DATABASE.look_up(ip)
	end
end