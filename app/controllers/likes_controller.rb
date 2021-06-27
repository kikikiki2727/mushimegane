class LikesController < ApplicationController

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
