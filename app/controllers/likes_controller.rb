class LikesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @current_ip = request.remote_ip
    @comment.likes.create(global_ip: @current_ip)
  end

  def destroy
    like = Like.find(params[:id])
    @comment = like.comment
    like.destroy!
  end
end
