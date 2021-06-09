class CommentsController < ApplicationController
  skip_before_action :require_login

  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to bug_path(comment.bug), success: 'レビューを投稿しました'
    else
      redirect_to bug_path(comment.bug), danger: 'レビューが投稿できませんでした'
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to bug_path(@comment.bug), success: 'レビューを削除しました'
  end

  private

  def comment_params
    params.require(:comment).permit(:sentence).merge(bug_id: params[:bug_id])
  end
end
