class NewsController < ApplicationController
  include NewsHelper

  skip_before_action :require_login

  def index
    @news_list = get_news
  end
end
