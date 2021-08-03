class BugsController < ApplicationController
  include SearchImagesHelper

  before_action :set_bug, only: %i[edit update destroy]
  skip_before_action :require_login, only: %i[index show image_search]

  def index
    @search_bugs_form = SearchBugsForm.new(search_params)
    @bugs = @search_bugs_form.search.page(params[:page])
  end

  def show
    @bug = Bug.find(params[:id])
    @radar_chart = @bug.radar_chart
    @other_bug = Bug.includes(:radar_chart).where.not(id: @bug.id).shuffle.first
    @comments = @bug.comments.order(created_at: :desc)
    @comment = Comment.new
    @url = bug_comments_path(@bug)
  end

  def new
    @bug_radar_chart_form = BugRadarChartForm.new
  end

  def edit; end

  def create
    @bug_radar_chart_form = BugRadarChartForm.new(bug_radar_chart_params)
    @bug_radar_chart_form.save!
    @bug = Bug.last
    redirect_to @bug, success: '登録しました'
  rescue ActiveRecord::RecordInvalid => e
    @bug_radar_chart_form = e.record
    flash.now[:danger] = '登録できませんでした'
    render :new
  end

  def update
    @bug_radar_chart = BugRadarChartForm.new(bug_params)
      redirect_to @bug, success: '更新しました'
      flash.now[:danger] = '更新できませんでした'
      render :new
  end

  def destroy
    @bug.destroy!
    redirect_to bugs_path, success: '削除しました'
  end

  def image_search
    if params[:image]
      label_list = upload_image(params[:image])
      bug_array = label_search(label_list)
      @bugs = if bug_array.present?
                Bug.where(name: bug_array.map(&:name)).page(params[:page])
              else
                Bug.none.page(params[:page])
              end
      render :index
    else
      redirect_to bugs_path
    end
  end

  private

  def set_bug
    @bug = current_user.bugs.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:name, :feature, :approach, :prevention, :harm, :size, :color, :season, :image)
  end

  def search_params
    params[:search]&.permit(:name, :search_word, :size, :color, :season, :capture, :breeding,
                            :prevention_difficulty, :injury, :discomfort)
  end

  def bug_radar_chart_params
    params.require(:bug_radar_chart_form).permit(:name, :feature, :approach, :prevention, :harm, 
                                     :size, :color, :season, :capture, :breeding,
                                     :prevention_difficulty, :injury, :discomfort, 
                                     :image).merge(user_id: current_user.id)
  end
end
