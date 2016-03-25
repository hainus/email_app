class EmailsController < ApplicationController
  def index
    emails = Email.where(user_id: current_user.id)
    render :json => {emails: emails}
  end

  def create
    email = Email.new
    email.subject  = params[:subject]
    email.content  = params[:content]
    email.draf     = params[:draft]
    email.receiver_email  = params[:email]
    email.user_id  = current_user.id
    email.sender_email  = current_user.email

    if email.save
      # if email.draf

        # Notification.create(
        #   user_id: User.where(email: params[:email]).first.id,
        #   email_id: email.id,
        #   message: I18n.t("notification_message", name: current_user.email)
        # )

        if params[:file]
          params[:file].values.each do |file|
            attachment = AttachFile.new
            attachment.email_id = email.id
            attachment.attach_file = file
            attachment.save
          end
        end

      # end
    end

    render :json => {success: email}
  end

  def inbox
    emails = Email.where(receiver_email: current_user.email)
    render :json => {emails: emails}

  end

  def destroy
    emails = Email.where(user_id: current_user.id)
    email = Email.find(params[:id])
    email.destroy

    render :json => {success: emails}
  end

  def outbox
    emails = Email.where(sender_email: current_user.email)
    render :json => {emails: emails}
  end

  def draft
    emails = Email.where(user_id: current_user.id, draf: true)
    render :json => {emails: emails}
  end

  def detail
    email_detail = Email.where(id: params[:id]).first
    render :json => {email: email_detail.as_json(attachments: true)}
  end
end
