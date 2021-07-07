class SearchImagesController < ApplicationController
  include SearchImagesHelper

  def new; end

  def create
    data = params[:search][:image]
    label_list = upload_image(data)
    bug_array = label_search(label_list)
    if bug_array.present?
      @bugs = Bug.where(name: bug_array.map(&:name)).page(params[:page])
    else
      @bugs = Bug.none.page(params[:page])
    end
    render 'bugs/index'
  end
end
