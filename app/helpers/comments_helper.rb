module CommentsHelper
  def sort_type(type)
    if type == 'like'
      @comments = @bug.comments.sort_like
    elsif type == 'asc'
      @comments = @bug.comments.order(created_at: :asc)
    else
      @comments = @bug.comments.order(created_at: :desc)
    end
  end
end