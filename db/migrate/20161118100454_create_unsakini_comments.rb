class CreateUnsakiniComments < ActiveRecord::Migration[5.0]
  def change
    create_table :unsakini_comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
