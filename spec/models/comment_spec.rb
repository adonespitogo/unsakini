require 'rails_helper'

RSpec.describe Unsakini::Comment, type: :model do

  before(:all) do
    user_is_sharing_a_board_scenario
  end

  let(:invalid_attributes) {
    {
      user_id: @user.id,
      post_id: @post.id,
      content: ''
    }
  }


  it_behaves_like 'encryptable', [:content]

  it "validates title and content" do
    comment = Unsakini::Comment.new(invalid_attributes)
    comment.save
    expect(comment.errors.count).to be 1
  end

end
