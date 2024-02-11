# frozen_string_literal: true

require 'json'
require 'open-uri'
require 'digest/md5'
require 'dotenv/load'

class MarvelApiClient
  BASE_URL = 'https://gateway.marvel.com/v1/public'
  SUNSPOT_CHARACTER_ID = '1009638'

  def self.run(*args)
    new(*args).run
  end

  def generate_auth_params
    load_api_keys
    timestamp = Time.now.to_i.to_s
    auth_hash = Digest::MD5.hexdigest("#{timestamp}#{@private_key}#{@public_key}")
    "ts=#{timestamp}&apikey=#{@public_key}&hash=#{auth_hash}"
  end

  def load_api_keys
    @public_key = ENV.fetch('MARVEL_PUBLIC_KEY', nil)
    @private_key = ENV.fetch('MARVEL_PRIVATE_KEY', nil)
  end
end
