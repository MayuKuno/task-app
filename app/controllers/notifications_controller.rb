class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications

    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end

    @warnings = []
    @expireds = []
    current_user.tasks.each do |task|
      if task.deadline.to_date == Date.today + 1
        if task.status != "Completed" 
          @warnings << task
        end
      elsif task.deadline.to_date < Date.today + 1
        if task.status != "Completed"
          @expireds << task
        end

      end
    end
  end
end

