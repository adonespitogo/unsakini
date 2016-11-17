class CreateUserBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :user_boards do |t|
      t.integer :user_id
      t.integer :board_id
      t.boolean :is_admin, :default => false

      t.timestamps
    end
  end
end
