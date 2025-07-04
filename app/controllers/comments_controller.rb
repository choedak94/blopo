class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :authorize_comment!, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to @comment.blog_post
    else
      redirect_to @comment.blog_post, alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    blog_post = @comment.blog_post
    @comment.destroy
    redirect_to blog_post
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :blog_post_id, :parent_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_comment!
    unless current_user == @comment.user || current_user == @comment.blog_post.user
      redirect_to @comment.blog_post, alert: "You are not authorized to perform this action."
    end
  end
end
