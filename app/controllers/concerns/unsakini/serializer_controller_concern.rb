module Unsakini
  module SerializerControllerConcern

    extend ActiveSupport::Concern

    included do
      include ::ActionController::Serialization
    end


  end

end
