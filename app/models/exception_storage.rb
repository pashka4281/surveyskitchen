class ExceptionStorage < ActiveRecord::Base
	attr_accessible :created_at, :e_class, :message, :trace

	def self.from_exception(exception)
		create(e_class: exception.class.to_s, message: exception.message.to_s, trace: exception.backtrace.join("\n"))
	end

	after_create do
		ExceptionMailer.new_exception_notify(self).deliver
	end
end
