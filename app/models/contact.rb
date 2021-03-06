class Contact < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
end