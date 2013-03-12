require 'csv'

class Client < ActiveRecord::Base
  attr_accessible :account_id, :client_list_id, :email, :first_name, :full_name, :last_name, :note

  belongs_to :client_list
  belongs_to :account

  validates :email, :first_name, :last_name, presence: true
  validates :email, format: {:with => /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i}

  def first_name=(val)
  	write_attribute(:first_name, val.to_s.match(/\w{1,}/).to_s)
  end

  def last_name=(val)
  	write_attribute(:last_name, val.to_s.match(/\w{1,}/).to_s)
  end

  def self.create_from_csv_string(current_account, csv_text)
  	unprocessed = []
  	csv = CSV.parse(csv_text)
  	csv.each do |row|
  		row.collect!{|x| x.to_s }
		if current_account.clients.find_by_email(row[0])
			next
		else
			_cl = self.new(
				account_id: current_account.id, 
				email: row[0], 
				first_name: row[1], 
				last_name: row[2], 
				note: row[3])
			if _cl.save
				next
			end
		end
		unprocessed << row.join(',')
	end
	{unprocessed_lines: unprocessed.join("\r\n"), saved: csv.count - unprocessed.count, total: csv.count}
  end

  before_save do
  	self.full_name = [first_name, last_name].join(' ')
  end
end
