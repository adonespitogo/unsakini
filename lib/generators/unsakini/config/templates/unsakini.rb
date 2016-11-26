Unsakini.setup do |config|
  # your application encryption key
  config.unsakini_crypto_key = "change me"
  # default mail delivery method
  config.action_mailer.delivery_method = :letter_opener
end
