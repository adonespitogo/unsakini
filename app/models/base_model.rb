#Base model, inherits ApplicationRecord

class BaseModel < ApplicationRecord
  include EncryptableModelConcern

  self.abstract_class = true
end
