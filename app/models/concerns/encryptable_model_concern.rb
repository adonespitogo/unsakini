require 'openssl'
require 'base64'

module EncryptableModelConcern
  extend ActiveSupport::Concern

  included do
    before_save :encrypt_values
    after_save :decrypt_values
    after_find :decrypt_values
  end

  module ClassMethods
    #Sets the model encryptable_attributes. They are defined in the model using `encryptable_attributes` class method.
    #
    # Example:
    # ```
    #   class Board < BaseModel
    #     encryptable_attributes :name, :title, :content
    #   end
    # ```
    def encryptable_attributes(*attrs)
      @encryptable_attributes = attrs
    end
  end

  # Returns the model's encryptable attributes. Encryptable attributes are encrypted before saving using `before_save` hook and decrypted
  #
  # using `after_save` and `after_find` hooks.
  # @return [Array] array of model attribute names in symbol.
  def encryptable_attributes
    self.class.instance_variable_get(:@encryptable_attributes)
  end


  # Encryptes the model's encryptable attributes before saving using Rails' `before_save` hook.
  def encrypt_values
    return if encryptable_attributes.nil?
    encryptable_attributes.each do |k|
      self[k] = encrypt(self[k])
    end
  end

  # Decrypts the model's encryptable attributes using Rails' `after_save` and `after_find` hooks.
  def decrypt_values
    return if encryptable_attributes.nil?
    encryptable_attributes.each do |k|
      self[k] = decrypt(self[k])
    end
  end

  private
    def cipher
      OpenSSL::Cipher::Cipher.new('aes-256-cbc')
    end

    def cipher_key
      Rails.configuration.crypto['key']
    end

    def encrypt(value)
      c = cipher.encrypt
      c.key = Digest::SHA256.digest(cipher_key)
      c.iv = iv = c.random_iv
      Base64.encode64(iv) + Base64.encode64(c.update(value.to_s) + c.final)
    end

    def decrypt(value)
      c = cipher.decrypt
      c.key = Digest::SHA256.digest(cipher_key)
      c.iv = Base64.decode64 value.slice!(0,25)
      c.update(Base64.decode64(value.to_s)) + c.final
    end

end