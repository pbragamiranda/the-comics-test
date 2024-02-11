# frozen_string_literal: true

require_relative 'marvel_api_client'

class CharactersByStoryFetcher < MarvelApiClient
  def initialize(story)
    @story = story
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
    auth_params = generate_auth_params
    character_serialized = OpenURI.open_uri("#{BASE_URL}/characters/#{character_id}?#{auth_params}").read
    JSON.parse(character_serialized)['data']['results'][0]
  end

  def generate_image_url(image_data)
    "#{image_data['path']}.#{image_data['extension']}"
  end
end
