class ContactsController < ApplicationController
  before_action :authenticate_user!
  def index
    # contacts = Contact.where(user_id: current_user.id)
    # render :json => {contacts: contacts}

    contacts = current_user.contacts
    if params[:show_all]
      {
        data: contacts
      }
    else
      filter_params = params[:filter]
      if filter_params
        contacts = contacts.where("name like :name and email like :email and phone_number like :phone_number", {
          name: "%#{filter_params['name'].to_s.strip}%",
          email: "%#{filter_params['email'].to_s.strip}%",
          phone_number: "%#{filter_params['phone_number'].to_s.strip}%",
        })
      end

      sorting_params = params[:sorting]
      contacts = contacts.order("#{sorting_params.first.first} #{sorting_params.first.last}") if sorting_params

      page = params[:page] || FIRST_PAGE
      per_page = params[:per_page] || PER_PAGE
      contacts = contacts.paginate(:page => page, :per_page => per_page)

      render :json =>
      {
        data: contacts,
        total: contacts.total_entries
      }
    end
  end

  def create
    # raise params.inspect
    contact = Contact.new
    contact.name  = params[:name]
    contact.email  = params[:email]
    contact.phone_number     = params[:phone_number]
    contact.user_id  = current_user.id
    contact.save
    render :json => {success: contact}
  end



end
