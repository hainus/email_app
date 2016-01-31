class ContactsController < ApplicationController
  def index
    contacts = Contact.where(user_id: current_user.id)
    render :json => {contacts: contacts}
  end

  def create
    contact = Contact.new
    contact.name  = params[:name]
    contact.email  = params[:email]
    contact.phone_number     = params[:phone_number]
    contact.user_id  = current_user.id
    contact.save
    render :json => {success: contact}
  end



end
