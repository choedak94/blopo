class BlogPostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy, :like, :dislike]
  before_action :load_blog_post, only: [:edit, :update, :show, :destroy, :like, :dislike]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def dashboard
    @blog_posts = BlogPost.published
    if params[:q].present?
      query = "%#{params[:q]}%"
      @blog_posts = @blog_posts.where("title ILIKE ?", query)
    end
    @pagy, @blog_posts = pagy(@blog_posts)
  end

  def index
    @blog_posts = current_user.blog_posts
    if params[:q].present?
      query = "%#{params[:q]}%"
      @blog_posts = @blog_posts.where("title ILIKE ?", query)
    end
    @pagy, @blog_posts = pagy(@blog_posts)
  end

  def show
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
		@blog_post = current_user.blog_posts.build(resource_params)
		if @blog_post.save
			redirect_to @blog_post
		else
			flash.now[:error] = @blog_post.errors.full_messages
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

  def like
    vote = @blog_post.votes.find_by(user: current_user)
    if vote&.value == 1
      vote.destroy
    else
      vote&.update(value: 1) || @blog_post.votes.create(user: current_user, value: 1)
    end
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(view_context.dom_id(@blog_post, :votes), partial: "blog_posts/vote_buttons", locals: { blog_post: @blog_post }) }
      format.html { redirect_to @blog_post }
    end
  end

  def dislike
    vote = @blog_post.votes.find_by(user: current_user)
    if vote&.value == -1
      vote.destroy
    else
      vote&.update(value: -1) || @blog_post.votes.create(user: current_user, value: -1)
    end
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(view_context.dom_id(@blog_post, :votes), partial: "blog_posts/vote_buttons", locals: { blog_post: @blog_post }) }
      format.html { redirect_to @blog_post }
    end
  end

  private

  def resource_params
    params.require(:blog_post).permit(:title, :description, :published_at, :video)
  end

  def load_blog_post
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def authenticate_user!
    redirect_to new_user_session_path unless user_signed_in?
  end

  def authorize_user!
    unless current_user == @blog_post.user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to @blog_post
    end
  end
end
