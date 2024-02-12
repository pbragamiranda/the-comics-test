# frozen_string_literal: true

require_relative 'marvel_api_client'

class CharactersByStoryFetcher < MarvelApiClient
  REDIS_TTL = 24 * 60 * 60

  def initialize(story)
    @story = story
    @redis = Redis.new
    @auth_params = generate_auth_params
  end

  def run
    fetch_characters_for_story(@story)
  end

  private

  def fetch_characters_for_story(story)
    story.characters_ids.map { |character_id| fetch_and_build_character(character_id) }
  end

  def fetch_and_build_character(character_id)
    character_data = fetch_character_data(character_id)
    Character.new(character_id,
                  character_data['name'],
                  generate_image_url(character_data['thumbnail']))
  end

  def fetch_character_data(character_id)
    @cache_key = "character:#{character_id}"
    @redis.get(@cache_key) ? JSON.parse(@redis.get(@cache_key)) : fetch_data_from_api(character_id)
  end

  def fetch_data_from_api(character_id)
    character_serialized = OpenURI.open_uri("#{BASE_URL}/characters/#{character_id}?#{@auth_params}").read
    character_data = JSON.parse(character_serialized)['data']['results'][0]
    cache_character_data(character_data)
    character_data
  end

  def generate_image_url(image_data)
    "#{image_data['path']}.#{image_data['extension']}"
  end

  def cache_character_data(character_data)
    filtered_data = {
      'name' => character_data['name'],
      'thumbnail' => character_data['thumbnail']
    }

    @redis.set(@cache_key, filtered_data.to_json, ex: REDIS_TTL)
  end
end


