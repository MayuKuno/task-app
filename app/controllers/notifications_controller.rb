class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
