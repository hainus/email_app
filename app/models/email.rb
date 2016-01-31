class Email < ActiveRecord::Base
  belongs_to :user
  has_many :attach_files, dependent: :destroy
  validates :subject, presence: true

  def as_json(options = {})
    json = super(options)
    if options[:attachments]
      json[:attachments] = attach_files.as_json(methods: [:data])
    end

    json
  end

end