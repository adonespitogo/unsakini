class AddEncryptedPasswordToUserBoard < ActiveRecord::Migration[5.0]
  def change
    add_column :user_boards, :encrypted_password, :string
  end
end
