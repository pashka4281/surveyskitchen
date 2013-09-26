class AddPassedTextToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :submit_btn_txt, :string
    add_column :surveys, :passed_message, :text

    Survey.where("account_id NOT NULL").each do |s|
      YAML.load_file(Rails.root.join('config', 'defaults', 'surveys.yml'))[s.user.language].each do |key, val|
        s.send("#{key}=", val)
        s.save
      end
    end
  end

  def self.down
    remove_column :surveys, :submit_btn_txt
    remove_column :surveys, :passed_message  
  end
end
