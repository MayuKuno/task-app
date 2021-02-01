class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :render_maintenance_page


  # メンテナンス
  def render_maintenance_page
    if File.exist?('config/tmp/maintenance.yml')
      render file: Rails.public_path.join('maintenance.html'), layout: false
    end
  end




  private
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

end
