class CreateUnsakiniBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :unsakini_boards do |t|
      t.text :name
      t.boolean :is_shared, default: false

      t.timestamps
    end
  end
end
