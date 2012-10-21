class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
    	t.integer 	:survey_id
    	t.text 		:user_agent_string
    	t.text 		:content
    	t.string 	:remote_ip

    	t.datetime :created_at
    end
  end
end
