class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :email_id
      t.text :message
      t.boolean :is_viewed, default: false
    end
    add_index :notifications, :user_id
  end
end
