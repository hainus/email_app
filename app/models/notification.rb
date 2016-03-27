class Notification < ActiveRecord::Base
  belongs_to :user
  has_one :email
  scope :user_noti, ->(user_id) { where(user_id: user_id) }
end