class CommentsController < ApplicationController
  before_action :set_bug, only: :create

  def create
    @current_ip = request.remote_ip
    @comment = @bug.comments.build(comment_params.merge(global_ip: @current_ip))
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    bug = @comment.bug
    @comment.destroy!
    @comments_count = bug.comments.count
  end

  def sort
    @bug = Bug.find(params[:bug_id])
    @comments = @bug.sort_type(params[:type])
    @current_ip = request.remote_ip
  end

  private

  def set_bug
    @bug = Bug.find(params[:bug_id])
  end

  def comment_params
    params.require(:comment).permit(:sentence)
  end
end
