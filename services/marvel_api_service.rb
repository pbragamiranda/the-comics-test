# frozen_string_literal: true

require 'json'
require 'open-uri'
require 'digest/md5'
require 'dotenv/load'

class MarvelApiService
  BASE_URL = 'https://gateway.marvel.com/v1/public'
  SUNSPOT_CHARACTER_ID = '1009638'

  def initialize
    @public_key = ENV.fetch('MARVEL_PUBLIC_KEY', nil)
    @private_key = ENV.fetch('MARVEL_PRIVATE_KEY', nil)
  end

  def fetch_random_story_by_character(character_id)
    story_data = fetch_story_data(character_id)
    build_story(story_data)
  end

  def fetch_story_characters(story)
    story.characters_ids.map { |character_id| fetch_and_build_character(character_id) }
  end

  private

  def generate_auth_params
    timestamp = Time.now.to_i.to_s
    auth_hash = Digest::MD5.hexdigest("#{timestamp}#{@private_key}#{@public_key}")
    "ts=#{timestamp}&apikey=#{@public_key}&hash=#{auth_hash}"
  end

  def fetch_story_data(character_id)
    auth_params = generate_auth_params
    data_serialized = OpenURI.open_uri("#{BASE_URL}/stories?characters=#{character_id}&#{auth_params}").read
    JSON.parse(data_serialized)['data']['results'].sample
  end

  def build_story(story_data)
    story = Story.new(story_data['title'], story_data['description'])
    story.characters_ids = fetch_characters_ids(story_data['characters']['items'])
    story
  end

  def fetch_characters_ids(characters_data)
    characters_data.map { |character| character['resourceURI'].split('/')[-1] }
  end

  def fetch_and_build_character(character_id)
    character_data = fetch_character_data(character_id)
    Character.new(character_id,
                  character_data['name'],
                  generate_image_url(character_data['thumbnail']))
  end

  def fetch_character_data(character_id)
    auth_params = generate_auth_params
    character_serialized = OpenURI.open_uri("#{BASE_URL}/characters/#{character_id}?#{auth_params}").read
    JSON.parse(character_serialized)['data']['results'][0]
  end

  def generate_image_url(image_data)
    "#{image_data['path']}.#{image_data['extension']}"
  end
end
