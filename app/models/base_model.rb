class BaseModel < ActiveRecord::Base
  include EncryptableModelConcern

  self.abstract_class = true
end
