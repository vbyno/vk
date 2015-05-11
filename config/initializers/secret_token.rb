# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

development:
  domain_name: example.com
  secret_key_base: dd2da6836002254cac82d1a02a563871344cf761285a04055158734cd631c796c7688f6934d453bdf876d6e74a690bc79c8f8d71992bba8b0032d25e136535e5

test:
  secret_key_base: a4ba8095e8a462903f3ea5cfeebaf74c484082de68b58100cbad0481f836cb4801d6e8c0882918a55459b298878a083bd44ccab147f1657b3384196c47bf5a11

# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  domain_name: <%= ENV["DOMAIN_NAME"] %>
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>