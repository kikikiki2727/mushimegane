module ApplicationHelper
  def pages_title(page_title = '')
    base_title = 'むしめがね'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
