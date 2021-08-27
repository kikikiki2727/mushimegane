class BugsController < ApplicationController
  include SearchImagesHelper

  before_action :set_bug, only: %i[edit update destroy]
  before_action :set_radar_chart, only: %i[edit update destroy]
  before_action :set_bug_radar_chart_form, only: %i[edit update destroy]
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @search_bugs_form = SearchBugsForm.new(search_params)
    @bugs = @search_bugs_form.search.page(params[:page])
  end

  def show
    @bug = Bug.find(params[:id])
    @radar_chart = @bug.radar_chart
    @other_bug = Bug.includes(:radar_chart).where.not(id: @bug.id).sample
    @comments = @bug.comments.order(created_at: :desc)
    @comment = Comment.new
    @url = bug_comments_path(@bug)
    @current_ip = request.remote_ip
  end

  def new
    @bug_radar_chart_form = BugRadarChartForm.new
    @bug = Bug.new
  end

  def create
    @bug_radar_chart_form = BugRadarChartForm.new(bug_radar_chart_form_params)
    @bug_radar_chart_form.create!
    @bug = Bug.last
    redirect_to @bug, success: t('.success')
  rescue ActiveRecord::RecordInvalid => e
    @bug_radar_chart_form = e.record
    @bug = Bug.new
    flash.now[:danger] = t('.fail')
    render :new
  end

  def edit; end

  def update
    @bug_radar_chart_form = BugRadarChartForm.new(bug_radar_chart_form_params)
    @bug_radar_chart_form.update!(@bug, @radar_chart)
    redirect_to @bug, success: t('.success')
  rescue ActiveRecord::RecordInvalid => e
    @bug_radar_chart_form = e.record
    flash.now[:danger] = t('.fail')
    render :new
  end

  def destroy
    @bug.destroy!
    redirect_to bugs_path, success: t('.success')
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

  def set_radar_chart
    @radar_chart = @bug.radar_chart
  end

  def set_bug_radar_chart_form
    @bug_radar_chart_form = BugRadarChartForm.new(name: @bug.name, feature: @bug.feature, approach: @bug.approach,
                                                  prevention: @bug.prevention, harm: @bug.harm, size: @bug.size,
                                                  color: @bug.color, season: @bug.season, capture: @radar_chart.capture,
                                                  breeding: @radar_chart.breeding, injury: @radar_chart.injury,
                                                  prevention_difficulty: @radar_chart.prevention_difficulty,
                                                  discomfort: @radar_chart.discomfort)
  end

  def search_params
    params[:search]&.permit(:name, :search_word, :size, :color, :season, :capture, :breeding,
                            :prevention_difficulty, :injury, :discomfort)
  end

  def bug_radar_chart_form_params
    params.require(:bug_radar_chart_form).permit(:name, :feature, :approach, :prevention, :harm,
                                                 :size, :color, :season, :capture, :breeding,
                                                 :prevention_difficulty, :injury, :discomfort,
                                                 :image).merge(user_id: current_user.id)
  end
end
