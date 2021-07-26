module ApplicationHelper
  def pages_title(page_title = '')
    base_title = 'むしめがね'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def header_if_static_controller
    render 'shared/header' unless params[:controller] == 'static_pages'
  end

  def margin_if_static_controller
    'top_margin' unless params[:controller] == 'static_pages'
  end

  def flash_if_static_controller
    render 'shared/flash_message' unless params[:controller] == 'static_pages'
  end
end
