require 'rails_helper'

RSpec.describe UserBoard, type: :model do
  it_behaves_like 'encryptable', [:encrypted_password]
end
