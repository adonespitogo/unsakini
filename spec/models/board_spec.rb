require 'rails_helper'

RSpec.describe Board, type: :model do
  it_behaves_like 'encryptable', [:name]

  it "can be shared to other users" do
    user_is_sharing_a_board_scenario

    new_key = Faker::Crypto.md5

    user_2_boards_count = @user_2.boards.count
    user_3_boards_count = @user_3.boards.count
    user_4_boards_count = @user_4.boards.count

    expect(@board.share(@user.id, [@user_2.id, @user_3.id, @user_4.id], new_key)).to be true
    # todo: check validation

    expect(@user_2.boards.count).to eq(user_2_boards_count+1)
    expect(@user_3.boards.count).to eq(user_3_boards_count+1)
    expect(@user_4.boards.count).to eq(user_4_boards_count+1)

    expect(UserBoard.where(
             is_admin: true,
             board_id: @board.id,
             user_id: [@user_2.id, @user_3.id, @user_4.id]
    ).count).to eq 0
    expect(UserBoard.where(
             board_id: @board.id,
             user_id: [@user_2.id, @user_3.id, @user_4.id]
    ).count).to eq 3

  end
end
