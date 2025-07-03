class UsersController < ApplicationController
  before_action :set_user

  def show
    @blog_posts = @user.blog_posts.published
    @pagy, @blog_posts = pagy(@blog_posts)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
