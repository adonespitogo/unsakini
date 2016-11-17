require 'rails_helper'
require 'models/concerns/encryptable_concern'

RSpec.describe Board, type: :model do

  describe 'Board Model' do
    it_behaves_like 'encryptable'
  end

end
