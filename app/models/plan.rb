class Plan < ActiveRecord::Base
  attr_accessible :name, :price, :remove_survey_footer,
    :custom_logo, :surveys_count_limit, :responses_count_limit

  has_many :subscriptions
  has_many :accounts, through: :subscriptions
end
