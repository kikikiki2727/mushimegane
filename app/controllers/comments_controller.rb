class CommentsController < ApplicationController
  include CommentsHelper

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  def sort
    @bug = Bug.find(params[:bug_id])
    sort_type(params[:bug][:type])
  end

  private

  def comment_params
    params.require(:comment).permit(:sentence).merge(bug_id: params[:bug_id])
  end
end
