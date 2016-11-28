# Base application model
require_dependency 'unsakini'
module Unsakini
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
