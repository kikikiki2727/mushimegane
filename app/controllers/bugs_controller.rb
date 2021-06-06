class BugsController < ApplicationController
  before_action :set_bug, only: %i[ show edit update destroy ]
  skip_before_action :require_login # , only: %i[ index show ]

  def index
    @bugs = Bug.all.page(params[:page])
  end

  def show
  end

  def new
    @bug = current_user.bugs.build
  end

  def edit
  end

  def create
    @bug = current_user.bugs.build(bug_params)
    @bug.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), filename: "default.png", content_type: "image/png") unless @bug.image.attached?
    @bug.illustration.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default.png')), filename: "default.png", content_type: "image/png") unless @bug.illustration.attached?
    if @bug.save
      redirect_to @bug, success: '登録しました'
    else
      flash.now[:danger] = '登録に失敗しました'
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

  private
    def set_bug
      @bug = Bug.find(params[:id])
    end

    def bug_params
      params.require(:bug).permit(:name, :feature, :approach, :prevention, :harm, :size, :color, :season, :image, :illustration)
    end
end