class CreateUnsakiniUserBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :unsakini_user_boards do |t|
      t.integer :user_id
      t.integer :board_id
      t.string :encrypted_password
      t.boolean :is_admin, :default => false

      t.timestamps
    end
  end
end
