class Blog::Post < ActiveRecord::Base
  self.table_name = "blog_posts"
  extend FriendlyId
  friendly_id :title, use: :slugged
  paginates_per 10

  attr_accessible :author_id, :content, :meta_description, :meta_keywords, :title
  validates :content, :title, :meta_keywords, :meta_description, presence: true
end
