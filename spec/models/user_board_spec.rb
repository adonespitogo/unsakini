require 'rails_helper'

RSpec.describe Unsakini::UserBoard, type: :model do

  it_behaves_like 'encryptable', [:encrypted_password]

  before(:each) do
    @user = create(:user)
    @user_2 = create(:user)
  end

  it "rejects nil board name" do
    board_count = Unsakini::Board.count
    user_board_count = Unsakini::UserBoard.count
    my_board_count = @user.boards.count

    user_board = Unsakini::UserBoard.new(
      user_id: @user.id,
      is_admin: true,
      encrypted_password: Faker::Crypto.md5
    )
    expect(user_board.save).to be false
    expect(@user.boards.count).to eq my_board_count
    expect(Unsakini::Board.count).to eq(board_count)
    expect(Unsakini::UserBoard.count).to eq(user_board_count)
  end

  it "rejects nil encrypted_password" do
    user_board_count = Unsakini::UserBoard.count
    my_board_count = @user.boards.count
    board = create(:board)
    board_count = Unsakini::Board.count

    user_board = Unsakini::UserBoard.new(
      user_id: @user.id,
      board_id: board.id,
      name: Faker::Name.title,
      is_admin: true
    )
    expect(user_board.save).to be false
    expect(@user.boards.count).to eq my_board_count
    expect(Unsakini::Board.count).to eq(board_count)
    expect(Unsakini::UserBoard.count).to eq(user_board_count)
  end

  it "creates Unsakini::UserBoard and it's Board" do
    board_name = Faker::Name.title
    my_board_count = @user.boards.count
    board_count = Unsakini::Board.count
    user_board_count = Unsakini::UserBoard.count

    user_board = Unsakini::UserBoard.new(name: board_name, user_id: @user.id, encrypted_password: Faker::Crypto.md5)
    expect(user_board.save).to be true
    expect(@user.boards.count).to eq my_board_count+1
    expect(Unsakini::Board.count).to eq(board_count+1)
    expect(Unsakini::UserBoard.count).to eq(user_board_count+1)
    expect(user_board.board.name).to eq board_name
  end

  it "updates the board name" do
    new_board_name = Faker::Name.title
    board = create(:board)
    user_board = create(:user_board, {user_id: @user.id, board_id: board.id})

    board = user_board.board
    user_board.name = new_board_name
    expect(board.name).not_to eq new_board_name
    user_board.save
    board.reload
    expect(board.name).to eq new_board_name

  end

  it "updates the encrypted_password" do
    board = create(:board)

    user_board = create(:user_board, {user_id: @user.id, is_admin: true, board_id: board.id })

    old_key = user_board.encrypted_password
    new_key = Faker::Crypto.md5

    expect(user_board.encrypted_password).not_to eq new_key
    user_board.encrypted_password = new_key
    expect(user_board.save).to be true
    expect(user_board.encrypted_password).to eq new_key

  end

  it "rejects invalid encrypted_password" do
    board = create(:board)
    user_board = create(:user_board, {user_id: @user.id, is_admin: true, board_id: board.id})

    old_key = user_board.encrypted_password

    expect(old_key).not_to be_nil
    user_board.encrypted_password = nil
    expect(user_board.save).to be false
    user_board.reload
    expect(user_board.encrypted_password).to eq old_key

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
    user_board.name = new_board_name
    user_board.encrypted_password = key
    user_board.save
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
    user_board.name = new_board_name
    user_board.encrypted_password = new_key
    user_board.save
    user_board_2.reload
    expect(user_board_2.encrypted_password).to be_falsy

  end

  it "can be shared to other users" do
    user_is_sharing_a_board_scenario

    new_key = Faker::Crypto.md5

    user_2_boards_count = @user_2.boards.count
    user_3_boards_count = @user_3.boards.count
    user_4_boards_count = @user_4.boards.count

    expect(@user_board.share([@user_2.id, @user_3.id, @user_4.id], new_key)).to be true
    # todo: check validation

    expect(@user_2.boards.count).to eq(user_2_boards_count+1)
    expect(@user_3.boards.count).to eq(user_3_boards_count+1)
    expect(@user_4.boards.count).to eq(user_4_boards_count+1)

    # make sure none of them is assign admin
    expect(Unsakini::UserBoard.where(
             is_admin: true,
             board_id: @board.id,
             user_id: [@user_2.id, @user_3.id, @user_4.id]
    ).count).to eq 0

    # make sure all has been shared with
    expect(Unsakini::UserBoard.where(
             board_id: @board.id,
             user_id: [@user_2.id, @user_3.id, @user_4.id]
    ).count).to eq 3

    expect(@user_board.board.reload.is_shared).to be true

  end

end
