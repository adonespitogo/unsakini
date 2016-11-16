class Board < ActiveRecord::Base
  include Encryptable

  encryptable_attributes [:name]

end
