require 'rails_helper'
require 'models/concerns/encryptable_concern'

RSpec.describe Board, type: :model do

  describe 'Board Model' do

    it_behaves_like 'encryptable'

    # it 'encrypts name' do
    #   board = create(:board)
    #   puts board.to_json
    # end
  end

end
