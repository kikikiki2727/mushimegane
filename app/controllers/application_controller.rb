class ApplicationController < ActionController::Base
  include ApplicationHelper

  add_flash_types :success, :info, :warning, :danger

  before_action :require_login

  private

  def not_authenticated
    redirect_to login_path, success: 'ログインしてください'
  end
end
