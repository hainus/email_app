class AddEmailToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :sender_email, :string
    add_column :emails, :receiver_email, :string
  end
end
