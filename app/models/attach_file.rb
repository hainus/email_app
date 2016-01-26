class AttachFile < ActiveRecord::Base
  has_attached_file :attach_file
  belongs_to :email
end