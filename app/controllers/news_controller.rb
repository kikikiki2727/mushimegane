class NewsController < ApplicationController
  include NewsHelper

  def index
    @news_list = get_news
  end
end
