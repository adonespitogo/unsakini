module SerializerControllerConcern

  extend ActiveSupport::Concern

  included do
    include ::ActionController::Serialization
    # respond_to :json
  end


end
