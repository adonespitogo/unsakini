require 'rails_helper'

RSpec.describe Unsakini::Post, type: :model do
  it_behaves_like 'encryptable', [:title, :content]

  let(:invalid_attributes) {
    {user_id: @user.id, board_id: @board.id, content: '', title: ''}
  }

  it "validates title and content" do

    user_is_sharing_a_board_scenario

    post = Unsakini::Post.new(invalid_attributes)
    post.save
    expect(post.errors.count).to be 2
  end

end
