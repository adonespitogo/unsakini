require 'openssl'
require 'base64'

# Responsible for encryption and decryption of certain model attributes

module EncryptableModelConcern
  extend ActiveSupport::Concern

  included do
    before_save :encrypt_encryptable_attributes
    after_save :decrypt_encryptable_attributes
    after_find :decrypt_encryptable_attributes
  end

  module ClassMethods
    # Sets the `encryptable_attributes` class instance variable in the model.
    #
    # Encryptable attributes are encrypted before saving using `before_save` hook and decrypted using `after_save` and `after_find` hooks.
    #
    # Example:
    # ```
    #   class Board < BaseModel
    #     encryptable_attributes :name, :title, :content
    #   end
    # ```
    # @param attrs [Symbol] model attributes
    #
    def encryptable_attributes(*attrs)
      @encryptable_attributes = attrs
    end

  end

  # Returns the model's `encryptable_attributes` class instance variable.
  #
  def encryptable_attributes
    self.class.instance_variable_get(:@encryptable_attributes) || []
  end

  private
  # Encryptes the model's encryptable attributes before saving using Rails' `before_save` hook.
  #
  # **Note: Be careful in calling this method manually as it can corrupt the data.**
  def encrypt_encryptable_attributes
    encryptable_attributes.each do |k|
      self[k] = encrypt(self[k])
    end
  end

  # Decrypts the model's encryptable attributes using Rails' `after_save` and `after_find` hooks.
  #
  # **Note: Be careful in calling this method manually as it can corrupt the data.**
  def decrypt_encryptable_attributes
    encryptable_attributes.each do |k|
      self[k] = decrypt(self[k])
    end
  end

  # Determins if the value being encrypted/decryped is empty.
  def is_empty_val(value)
    !value or value.nil? or value == ""
  end

  # Returns the cipher algorithm used
  def cipher
    OpenSSL::Cipher::Cipher.new('aes-256-cbc')
  end

  # Returns the encryption key from the `unsakini_crypto_key` config
  def cipher_key
    begin
      Rails.configuration.unsakini_crypto_key
    rescue Exception => e
      raise 'Encryption key is not set! Please run `rails g unsakini:config` before you proceed.'
    end
  end

  # Encrypts model attribute value
  def encrypt(value)
    return value if is_empty_val(value)
    c = cipher.encrypt
    c.key = Digest::SHA256.digest(cipher_key)
    c.iv = iv = c.random_iv
    Base64.encode64(iv) + Base64.encode64(c.update(value.to_s) + c.final)
  end

  # Decrypts model attribute value
  def decrypt(value)
    return value if is_empty_val(value)
    c = cipher.decrypt
    c.key = Digest::SHA256.digest(cipher_key)
    c.iv = Base64.decode64 value.slice!(0,25)
    c.update(Base64.decode64(value.to_s)) + c.final
  end

end
