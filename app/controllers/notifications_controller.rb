class NotificationsController < ApplicationController
  def index
    render :json => {
      Notification.user_noti(current_user.id).order("id DESC").limit(10)
    }
  end
end
