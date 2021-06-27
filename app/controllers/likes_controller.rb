class LikesController < ApplicationController

  def create
    @comment = Comment.find(params[:comment_id])
    current_user.like_comment(@comment)
  end

  def destroy
    @comment = Like.find(params[:id]).comment
    current_user.unlike_comment(@comment)
  end
end
