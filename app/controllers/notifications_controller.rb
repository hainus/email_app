class NotificationsController < ApplicationController
  def index
    render :json => {
      notifications: Notification.where(user_id: current_user.id),
      count_no_read: Notification.where(user_id: current_user.id, is_viewed: false).count
    }
  end
  def update_all_read
    Notification.where(user_id: current_user.id).update_all(is_viewed: true)
    render :json => {
      ok: true
    }
  end
end
