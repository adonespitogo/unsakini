class AddIsSharedToBoards < ActiveRecord::Migration[5.0]
  def change
    add_column :boards, :is_shared, :boolean, default: false
  end
end
