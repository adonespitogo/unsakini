# Base application model
module Unsakini
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    def self.tbl_prefix
      'unsakini_'
    end
  end
end
