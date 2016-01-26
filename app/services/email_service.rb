class EmailService < BaseService
  def get_list(params)
    if params[:is_draft]
      emails = Email.where(is_deleted: false, is_draft: true, user_id: current_user.id)
    elsif params[:inbox]
      emails = Email.joins(:message_accounts, :user).where("message_accounts.email = ? and message_accounts.is_deleted = ?", current_user.email, false)
    else
      emails = Email.joins(:message_accounts).where(is_deleted: false, is_draft: false, user_id: current_user.id)
    end

    filter_params = params[:filter]
    if filter_params
      email_param = "%#{filter_params['email'].to_s.strip}%"
      subject_param = "%#{filter_params['subject'].to_s.strip}%"
      emails = emails.where("subject like ?", subject_param)

      unless params[:is_draft]
        emails = params[:inbox] ? emails.where("users.email like ?", email_param) : emails.where("email like ?", email_param)
      end
    end

    sorting_params = params[:sorting]
    emails = sorting_params ? emails.order("#{sorting_params.first.first} #{sorting_params.first.last}") : emails.order("sent_time desc")

    page = params[:page] || FIRST_PAGE
    per_page = params[:per_page] || PER_PAGE
    emails = emails.group("emails.id").paginate(:page => page, :per_page => per_page)

    {
      data: emails,
      total: emails.total_entries
    }
  end
