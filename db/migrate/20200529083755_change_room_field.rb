class ChangeRoomField < ActiveRecord::Migration[5.2]
  def up
    change_column :rooms, :meeting_datetime, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
  def down
    change_column("rooms","meeting_datetime", :date, null: true)
  end
end
