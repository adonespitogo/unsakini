require 'rails_helper'

RSpec.describe UserBoard, type: :model do
  it_behaves_like 'encryptable', [:encrypted_password]

  before(:each) do
    @user = create(:user)
    @user_2 = create(:user)
  end

  it "creates user board and board" do
    board_name = Faker::Name.title
    encrypted_password = Faker::Crypto.md5
    board_count = Board.count
    user_board_count = UserBoard.count

    user_board = UserBoard.new(user_id: @user.id, encrypted_password: encrypted_password)
    expect(user_board.create_with_board(board_name)).to be true
    # todo: check validation
    user_board.reload
    expect(@user.boards.count).to eq 1
    expect(Board.count).to eq(board_count+1)
    expect(UserBoard.count).to eq(user_board_count+1)
    expect(user_board.board).not_to be_nil
    expect(user_board.board.user_boards.count).to eq 1
  end

  it "updates the board name" do
    new_board_name = Faker::Name.title
    key = Faker::Crypto.md5
    board = create(:board)
    user_board = create(:user_board, {
                          user_id: @user.id,
                          board_id: board.id,
                          is_admin: true,
                          encrypted_password: key
    })

    expect(board.name).not_to eq new_board_name
    user_board.update_password_and_board(new_board_name, key)
    board.reload
    expect(board.name).to eq new_board_name

  end

  it "doens't update user_boards.encrypted_password if key is the same" do
    new_board_name = Faker::Name.title
    key = Faker::Crypto.md5
    key2 = Faker::Crypto.md5

    board = create(:board)

    user_board = create(:user_board, {
                          user_id: @user.id,
                          board_id: board.id,
                          is_admin: true,
                          encrypted_password: key
    })

    user_board_2 = create(:user_board, {
                          user_id: @user_2.id,
                          board_id: board.id,
                          is_admin: false,
                          encrypted_password: key2
    })

    expect(user_board_2.encrypted_password).to eq key2
    user_board.update_password_and_board(new_board_name, key)
    user_board_2.reload
    expect(user_board_2.encrypted_password).to eq key2

  end

  it "updates user_boards.encrypted_password if key is new" do
    new_board_name = Faker::Name.title
    key = Faker::Crypto.md5
    key2 = Faker::Crypto.md5
    new_key = Faker::Crypto.md5
    board = create(:board)
    user_board = create(:user_board, {
                          user_id: @user.id,
                          board_id: board.id,
                          is_admin: true,
                          encrypted_password: key
    })

    user_board_2 = create(:user_board, {
                          user_id: @user_2.id,
                          board_id: board.id,
                          is_admin: false,
                          encrypted_password: key2
    })

    expect(user_board_2.encrypted_password).to eq key2
    user_board.update_password_and_board(new_board_name, new_key)
    user_board_2.reload
    expect(user_board_2.encrypted_password).to be_falsy

  end
end
