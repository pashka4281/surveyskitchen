class QuizItems::DescText < QuizItem
  attr_accessible :text_content

  custom_field_accessor :text_content
end