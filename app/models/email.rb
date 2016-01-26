class Email < ActiveRecord::Base
  belongs_to :user
  has_many :attach_files, dependent: :destroy
  validates :subject, presence: true

end