class BlogPostsController < ApplicationController
	before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :load_blog_post, only: [:edit, :update, :show, :destroy]

	def index
		@blog_posts = user_signed_in? ? BlogPost.all : BlogPost.published
		@pagy, @blog_posts = pagy(@blog_posts)
	end

	def show
	end

	def new
		@blog_post = BlogPost.new
	end

	def create
		@blog_post = BlogPost.create(resource_params)
		if @blog_post.save
			redirect_to @blog_post
		else
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def update
		if @blog_post.update(resource_params)
			redirect_to @blog_post
		else
			render :edit, status: :unprocessable_entity
		end
	end

  def destroy
		@blog_post.destroy
		redirect_to blog_posts_path, notice: "Blog post was successfully deleted."
	end

	private

	def resource_params
		params
		.require(:blog_post)
		.permit(:title, :content, :published_at)
	end

	def load_blog_post
		@blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		redirect_to root_path
	end

	def authenticate_user!
		redirect_to new_user_session_path unless user_signed_in?
	end
end
