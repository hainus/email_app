class Email < ActiveRecord::Base
  belongs_to :user
  default_scope { order(created_at: :desc) }
  has_many :attach_files, dependent: :destroy
  has_one  :notification
  after_create :create_notification
  validates :subject, presence: true

  def as_json(options = {})
    json = super(options)
    if options[:attachments]
      json[:attachments] = attach_files.as_json(methods: [:data])
    end

    json
  end

  def create_notification
    receiver_emails = JSON.parse(self.receiver_email)
    receiver_emails.each do |receiver_email|

      Notification.create(
        user_id: User.where(email: receiver_email).first.id,
        email_id: self.id,
        message: I18n.t("notification_message", name: self.user.email)
      )
    end
  end

end