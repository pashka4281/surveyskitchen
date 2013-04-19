class Blog::PostsController < ApplicationController
	before_filter :authenticate_admin!, only: [:new, :create, :edit, :update]
	skip_before_filter :set_locale
  before_filter :set_locale_marketing
	
  	inherit_resources
  	defaults :resource_class => Blog::Post, :collection_name => 'posts', :instance_name => 'post' 
  	# defaults :route_prefix => 'admin'
  	layout 'blog'

  	def index
  		@posts = Blog::Post.order('created_at DESC').page params[:page]
  	end

end
