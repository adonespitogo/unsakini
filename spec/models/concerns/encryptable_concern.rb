require 'spec_helper'

shared_examples_for "encryptable" do
  let(:model) { described_class } # the class that includes the concern

  let(:model_instance) {
    build(described_class.to_s.underscore.to_sym)
  }

  it "has encryptable attributes" do
    expect(model_instance.encryptable_attributes).not_to be_empty
  end

  it "encrypts encryptable attributes" do
    model_hash = json_str_to_hash(model_instance.to_json)
    model_instance.encrypt_values
    model_instance.encryptable_attributes.each do |attribute|
      expect(model_hash[attribute]).not_to eq(model_instance.send(attribute))
    end
  end

  it "decrypts encryptable attributes" do
    model_hash = json_str_to_hash(model_instance.to_json)
    model_instance.encrypt_values
    model_instance.decrypt_values
    model_instance.encryptable_attributes.each do |attribute|
      expect(model_hash[attribute]).to eq(model_instance.send(attribute))
    end
  end

  it "encrypts data before saving and decrypts it after saving" do
    model_hash = json_str_to_hash(model_instance.to_json)

    expect(model_instance).to receive(:encrypt_values)
    expect(model_instance).to receive(:decrypt_values)
    model_instance.save

    model_instance.encryptable_attributes.each do |attribute|
      expect(model_instance.send(attribute)).to eq(model_hash[attribute])
    end
  end

  it "decrypts data after find" do
    model_hash = json_str_to_hash(model_instance.to_json)

    model_instance.save

    find_model_instance = model.find(model_instance.id)
    find_model_instance.encryptable_attributes.each do |attribute|
      expect(find_model_instance.send(attribute)).to eq(model_hash[attribute])
    end
  end

end