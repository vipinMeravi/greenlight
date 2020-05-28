class ChangeRoom < ActiveRecord::Migration[5.2]
  def up
    add_column("rooms","website_url", :string, null: true)
    add_column("rooms","video_url", :string, null: true)
    add_column("rooms","meeting_datetime", :date, null: true)
    add_column("rooms","invite_emails", :string, null: true)
    add_column("rooms","upload_pdf", :string, null: true)
    add_column("rooms","upload_ppt", :string, null: true)
  end
  def down
    remove_column("rooms","website_url", :string)
    remove_column("rooms","video_url", :string)
    remove_column("rooms","meeting_datetime", :date)
    remove_column("rooms","invite_emails", :string)
    remove_column("rooms","upload_pdf", :string)
    remove_column("rooms","upload_ppt", :string)
  end
end
