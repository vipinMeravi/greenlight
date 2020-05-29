class ChangeRoomField < ActiveRecord::Migration[5.2]
  def up
    change_column :rooms, :meeting_datetime, :datetime, default: DateTime.current
  end
  def down
    change_column :rooms, :meeting_datetime, :datetime, default: DateTime.current
  end
end
