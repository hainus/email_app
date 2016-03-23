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

  def edit
    contact = Contact.find(params[:id])
  end

  def update
    contacts = Contact.where(user_id: current_user.id)
    contact = Contact.find(params[:id])
    contact.update(contact_params)

    render :json => {contacts: contacts}
  end

  def destroy
    contacts = Contact.where(user_id: current_user.id)
    contact = Contact.find(params[:id])
    contact.destroy

    render :json => {success: contacts}
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :phone_number, :email)
  end


end
