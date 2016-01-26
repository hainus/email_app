class CreateAttachFiles < ActiveRecord::Migration
  def change
    create_table :attach_files do |t|
      t.integer :email_id
      t.attachment :attach_file
      t.timestamps
    end
  end
end
