class CreateSurveyThemes < ActiveRecord::Migration
  def change
    create_table :survey_themes do |t|
		t.integer :account_id
		t.string :name, limit: 50 #"black mist", "white frost"

		#common survey styles
		t.string  :survey_bg_color, limit: 6
		
		#survey title
		t.boolean :survey_title_font_b
		t.boolean :survey_title_font_i
		t.boolean :survey_title_font_u
		t.string  :survey_title_txt_color, limit: 6
		t.string  :survey_title_bg_color, limit: 6

		#item title defaults
		t.boolean :item_title_font_b
		t.boolean :item_title_font_i
		t.boolean :item_title_font_u
		t.string  :item_title_txt_color, limit: 6

		t.string  :item_bg_color, limit: 6

		#item inner defaults
		t.boolean :item_inner_font_b
		t.boolean :item_inner_font_i
		t.boolean :item_inner_font_u
		t.string  :item_inner_txt_color, limit: 6

		

    	t.datetime :created_at
    end
  end
end
