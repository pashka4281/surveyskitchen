class CreatePosts < ActiveRecord::Migration
  def change
    # drop_table :blog_posts

    create_table :blog_posts do |t|
      t.string   :title
      t.text     :content
      t.integer  :author_id
      t.text     :meta_keywords, limit: 500
      t.text     :meta_description, limit: 800
      t.datetime :created_at
    end
  end
end
