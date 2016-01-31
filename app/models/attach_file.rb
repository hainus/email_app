class AttachFile < ActiveRecord::Base
  has_attached_file :attach_file
  do_not_validate_attachment_file_type :attach_file
  belongs_to :email
end