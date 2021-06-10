class RadarChartsController < ApplicationController
  before_action :set_bug

  def new
    @radar_chart = @bug.build_radar_chart
  end

  def create
    @radar_chart = @bug.build_radar_chart(radar_chart_params)
    if @radar_chart.save
      redirect_to @bug, success: 'レーダーチャートを登録しました'
    else
      flash.now[:danger] = 'レーダーチャートを作成できませんでした'
      render :new
    end
  end

  def edit
    @radar_chart = @bug.radar_chart
  end

  def update
    if @bug.radar_chart.update(radar_chart_params)
      redirect_to @bug, success: 'レーダーチャートを更新しました'
    else
      @radar_chart = @bug.radar_chart
      flash.now[:danger] = '更新に失敗しました'
      render :edit
    end
  end

  private
  
  def set_bug
    @bug = Bug.find(params[:bug_id])
  end

  def radar_chart_params
    params.require(:radar_chart).permit(:capture, :breeding, :quickness, :evil, :discomfort)
  end
end
