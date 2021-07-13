class BugsController < ApplicationController
  include SearchImagesHelper

  before_action :set_bug, only: %i[ show edit update destroy ]
  skip_before_action :require_login , only: %i[ index show ]

  def index
    @search_bugs_form = SearchBugsForm.new(search_params)
    @bugs = @search_bugs_form.search.page(params[:page])
  end

  def show
    @radar_chart = @bug.radar_chart
    @other_bug = Bug.where.not(id: @bug.id).shuffle.first
    # @other_bug = RadarChart.offset(rand(RadarChart.count)).first.bug
    @comments = @bug.comments.order(created_at: :desc)
    @comment = Comment.new
    @url = bug_comments_path(@bug)
  end

  def new
    @bug = current_user.bugs.build
  end

  def edit; end

  def create
    @bug = current_user.bugs.build(bug_params)
    @bug.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), filename: "default.png", content_type: "image/png") unless @bug.image.attached?
    if @bug.save
      redirect_to @bug, success: '登録しました'
    else
      flash.now[:danger] = '登録できませんでした'
      render :new
    end
  end

  def update
    if @bug.update(bug_params)
      redirect_to @bug, success: '更新しました'
    else
      flash.now[:danger] = '更新できませんでした'
      render :new
    end
  end

  def destroy
    @bug.destroy!
    redirect_to bugs_path, success: '削除しました'
  end

  def image_search
    if data = params[:image]
      label_list = upload_image(data)
      bug_array = label_search(label_list)
      if bug_array.present?
        @bugs = Bug.where(name: bug_array.map(&:name)).page(params[:page])
      else
        @bugs = Bug.none.page(params[:page])
      end
      render :index
    else
      redirect_to bugs_path
    end
  end

  private
    def set_bug
      @bug = Bug.find(params[:id])
    end

    def bug_params
      params.require(:bug).permit(:name, :feature, :approach, :prevention, :harm, :size, :color, :season, :image, :illustration)
    end

    def search_params
      params[:search]&.permit(:name, :search_word, :size, :color, :season, :capture, :breeding, :quickness, :harm, :discomfort)
    end
end
