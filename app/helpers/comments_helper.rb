module CommentsHelper
  def sort_type(type, bug)
    case type
    when 'like'
      bug.comments.sort_like
    when 'asc'
      bug.comments.order(created_at: :asc)
    else
      bug.comments.order(created_at: :desc)
    end
  end
end
