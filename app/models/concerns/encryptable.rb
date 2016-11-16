require 'openssl'
require 'base64'

module Encryptable
  extend ActiveSupport::Concern

  included do
    before_save :encrypt_values
    after_save :decrypt_values
    after_find :decrypt_values

    def self.encryptable_attributes(attrs)
      @@encrypted_attrs = attrs
    end
  end

  def encrypt_values
    @@encrypted_attrs.each do |k|
      self[k] = encrypt(self[k])
    end
  end

  def decrypt_values
    @@encrypted_attrs.each do |k|
      self[k] = decrypt(self[k])
    end
  end

  def encryptable_attributes
    @@encrypted_attrs
  end

  private
    def cipher
      OpenSSL::Cipher::Cipher.new('aes-256-cbc')  # ('aes-256-cbc')
    end

    def cipher_key
      if Rails.env.production? then ENV['CRYPTO_KEY'] else 'secret' end
    end

    def decrypt(value)
      c = cipher.decrypt
      c.key = Digest::SHA256.digest(cipher_key)
      c.update(Base64.decode64(value.to_s)) + c.final
    end

    def encrypt(value)
      c = cipher.encrypt
      c.key = Digest::SHA256.digest(cipher_key)
      Base64.encode64(c.update(value.to_s) + c.final)
    end
end