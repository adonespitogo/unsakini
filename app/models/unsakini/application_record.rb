# Base application model

module Unsakini
  class ApplicationRecord < ::ActiveRecord::Base
    self.abstract_class = true
  end
end
