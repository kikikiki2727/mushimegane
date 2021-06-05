class BugsController < ApplicationController
  before_action :set_bug, only: %i[ show edit update destroy ]
  skip_before_action :require_login # , only: %i[ index show ]

  def index
    @bugs = Bug.all
  end

  def show
  end

  def new
    @bug = Bug.new
  end

  def edit
  end

  def create
    @bug = Bug.new(bug_params)

    respond_to do |format|
      if @bug.save
        format.html { redirect_to @bug, notice: "Bug was successfully created." }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to @bug, notice: "Bug was successfully updated." }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to bugs_url, notice: "Bug was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_bug
      @bug = Bug.find(params[:id])
    end

    def bug_params
      params.require(:bug).permit(:name, :feature, :approach, :prevention, :harm, :size, :color, :seazon, :user_id)
    end
end
