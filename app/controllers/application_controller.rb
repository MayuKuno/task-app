class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :render_maintenance_page
  include SessionsHelper
  include NotificationsHelper


  # メンテナンス
  def render_maintenance_page
    if File.exist?('config/tmp/maintenance.yml')
      render file: Rails.public_path.join('maintenance.html'), layout: false
    end
  end




  private


end
