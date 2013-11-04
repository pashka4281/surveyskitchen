class AddHideSkFooterToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :hide_sk_footer, :boolean, default: false
  end
end
