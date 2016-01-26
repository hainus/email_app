class EmailsController < ApplicationController
  def create
    # raise params.inspect
    email = Email.new
    email.subject  = params[:subject]
    email.content  = params[:content]
    email.draf     = params[:draft]
    email.receiver_email  = params[:email]
    email.user_id  = current_user.id
    email.sender_email  = current_user.email
    attach_files   = params[:attach_files]

    email.save

    render :json => {success: email}
  end

  def inbox
    emails = Email.where(receiver_email: current_user.email)
    render :json => {emails: emails}

  end

  def outbox
    emails = Email.where(sender_email: current_user.email)
    render :json => {emails: emails}
  end

  def draft
    emails = Email.where(user_id: current_user.id, draf: true)
    render :json => {emails: emails}
  end

  # def email_detail
  #   email_detail = Email.where(user_id: current_user.id, draf: true)
  #   render :json => {emails: emails}
  # end
end
