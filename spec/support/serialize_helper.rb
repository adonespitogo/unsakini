module SerializeHelper

  def body_to_json(path = nil)
    parse_json(response.body, path)
  end

  def serializer(model_instance)
    # http://stackoverflow.com/questions/1235593/ruby-symbol-to-class
    begin
      serializer = "#{model_instance.class.name}Serializer".constantize
      begin
        ActiveModelSerializers::Adapter.create(serializer.new(model_instance))
      rescue Exception => e
        model_instance
      end
    rescue Exception => e
      if model_instance.class.name.eql? "ActiveRecord::AssociationRelation"
        model_instances = Array.new
        model_instance.each do |instance|
          model_instances << serializer(instance)
        end
        model_instances
      else
        model_instance
      end
    end
  end

  def serialize(model_instance)
    serializer(model_instance).to_json
  end

end

RSpec.configure do |config|
  config.include SerializeHelper
end
