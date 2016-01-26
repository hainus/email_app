class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :subject
      t.text :content
      t.boolean :draf, default: false
      t.integer :user_id
      t.timestamps
    end
    add_index :emails, :user_id
  end
end
