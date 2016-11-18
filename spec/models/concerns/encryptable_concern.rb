require 'spec_helper'

shared_examples_for "encryptable" do |attributes|
  let(:model) { described_class } # the class that includes the concern

  let(:model_instance) {
    build(described_class.to_s.underscore.to_sym)
  }

  it "has encryptable attributes" do
    expect(model_instance.encryptable_attributes).not_to be_empty
    expect(model_instance.encryptable_attributes).to eq(attributes)
  end

  it "encrypts encryptable attributes" do
    model_hash = model_as_hash(model_instance)
    model_instance.encrypt_encryptable_attributes
    model_instance.encryptable_attributes.each do |attribute|
      expect(model_hash[attribute]).not_to eq(model_as_hash(model_instance)[attribute])
    end
  end

  it "decrypts encryptable attributes" do
    model_hash = model_as_hash(model_instance)
    model_instance.encrypt_encryptable_attributes
    model_instance.decrypt_encryptable_attributes
    model_instance.encryptable_attributes.each do |attribute|
      expect(model_hash[attribute]).to eq(model_as_hash(model_instance)[attribute])
    end
  end

  it "encrypts data before saving and decrypts it after saving" do
    model_hash = model_as_hash(model_instance)
    expect(model_instance).to receive(:encrypt_encryptable_attributes)
    expect(model_instance).to receive(:decrypt_encryptable_attributes)
    model_instance.save validate: false
  end

  it "decrypts data after find" do
    model_hash = json_str_to_hash(model_instance.to_json)
    model_instance.save validate: false
    find_model_instance = model.find_by_id(model_instance.id)
    find_model_instance.encryptable_attributes.each do |attribute|
      expect(find_model_instance.send(attribute)).to eq(model_hash[attribute])
    end
  end

end