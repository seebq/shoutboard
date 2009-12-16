# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_shoutboard_session',
  :secret      => '254d50ac27720c99cb0cec20343b1babfa277565e27f9bca8a3170d2c191a7da49385f118a009c40a3cdb16f0ffae1805ef3dcc1fc7cde07325ae3374a8fec88'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
