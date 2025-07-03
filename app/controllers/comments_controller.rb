class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to @comment.blog_post
    else
      redirect_to @comment.blog_post, alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :blog_post_id, :parent_id)
  end
end
