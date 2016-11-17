# check response body equals model
RSpec::Matchers.define :equal_model do |expected|

  include Helpers

  match do |actual|
    actual == model_as_hash(expected)

  end

  failure_message do |actual|
    "\"#{actual}\" is not equal to model #{expected.class.name}"
  end

  description do
    "Expects to be Hash to equal model instance"
  end
end