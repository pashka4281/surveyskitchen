class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :text, :user_id
end
