class LikesController < ApplicationController
  skip_before_action :require_login

  def create
    comment = Comment.find(params[:comment_id])
    current_user.like_comment(comment)
    redirect_back fallback_location: root_path
  end

  def destroy
    comment = Like.find(params[:id]).comment
    current_user.unlike_comment(comment)
    redirect_back fallback_location: root_path
  end
end
