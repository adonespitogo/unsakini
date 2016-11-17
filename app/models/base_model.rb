class BaseModel < ActiveRecord::Base
  include Encryptable

  self.abstract_class = true
end
