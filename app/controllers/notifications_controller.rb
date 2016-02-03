class NotificationsController < ApplicationController
  def index
    render :json => {
      notifications: Notification.where(user_id: current_user.id).limit(10)
    }
  end
end
