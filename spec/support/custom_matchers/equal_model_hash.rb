# check response body equals model
RSpec::Matchers.define :equal_model_hash do |expected|

  include Helpers

  match do |actual|
    actual == model_as_hash(expected)
  end

  failure_message do |actual|
    if actual.class.name.eql? "String"
      actual = json_str_to_hash(actual)
    end
    "\"#{actual}\" is not equal to model #{expected.attributes}"
  end

  description do
    "Expects hash to equal model instance"
  end
end