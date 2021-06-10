class CommentsController < ApplicationController

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to bug_path(comment.bug), success: 'コメントを投稿しました'
    else
      redirect_to bug_path(comment.bug), danger: 'コメントを投稿できませんでした'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to bug_path(@comment.bug), success: 'コメントを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:sentence).merge(bug_id: params[:bug_id])
  end
end
