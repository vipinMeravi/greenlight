class AddRoomField < ActiveRecord::Migration[5.2]
  def up
    add_column("rooms","background_color", :string, null: true)
  end
  def down
    remove_column("rooms","background_color", :string)
  end
end
