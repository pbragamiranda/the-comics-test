# frozen_string_literal: true

require 'spec_helper'

describe StoryByCharacterFetcher do
  describe '#fetch_random_story_by_character' do
    it 'fetches a random story by character and returns a Story object' do
      VCR.use_cassette('fetch_random_story_by_character', match_requests_on: %i[method ignore_auth_params]) do
        story = StoryByCharacterFetcher.run(MarvelApiClient::SUNSPOT_CHARACTER_ID)

        expect(story).to be_a(Story)
        expect(story.title).to be_a(String)
        expect(story.description).to be_a(String)
        expect(story.characters_ids).to include(MarvelApiClient::SUNSPOT_CHARACTER_ID)
      end
    end
  end
end
