module NotificationsHelper
  def unchecked_notifications
    @notifications = current_user.notifications.where(checked: false)
  end
end