class CommentsController < ApplicationController
  include CommentsHelper
  skip_before_action :require_login, only: :sort

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    bug = Bug.find(params[:bug_id])
    @comments_count = bug.comments.count
  end

  def sort
    @bug = Bug.find(params[:bug_id])
    @comments = sort_type(params[:type], @bug)
  end

  private

  def comment_params
    params.require(:comment).permit(:sentence).merge(bug_id: params[:bug_id])
  end
end
