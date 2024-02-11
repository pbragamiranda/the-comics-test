# frozen_string_literal: true

require_relative 'marvel_api_client'

class StoryByCharacterFetcher < MarvelApiClient
  def initialize(character_id)
    @character_id = character_id
  end

  def run
    fetch_random_story_by_character(@character_id)
  end

  private

  def fetch_random_story_by_character(character_id)
    story_data = fetch_story_data(character_id)
    build_story(story_data)
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
end
