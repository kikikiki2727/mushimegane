module ApplicationHelper
  def pages_title(page_title = '')
    base_title = 'むしめがね'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def header_if_home_controller
    render 'shared/header' unless params[:controller] == 'home'
  end

  def margin_if_home_controller
    'top_margin' unless params[:controller] == 'home'
  end

  def flash_if_home_controller
    render 'shared/flash_message' unless params[:controller] == 'home'
  end
end
