require 'rails_helper'

RSpec.describe Unsakini::Board, type: :model do

  let(:invalid_attributes) {
    {
      name: ''
    }
  }

  it_behaves_like 'encryptable', [:name]

  it "validates name" do
    board = Unsakini::Board.new(invalid_attributes)
    board.save
    expect(board.errors.count).to be 1
  end

end
