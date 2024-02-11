# frozen_string_literal: true

require 'spec_helper'

describe CharactersByStoryFetcher do
  describe '#run' do
    it 'fetches characters for a given story and returns an array of Character objects' do
      VCR.use_cassette('fetch_story_characters', match_requests_on: %i[method ignore_auth_params]) do
        story = Story.new('name', 'description')
        story.characters_ids = ['1009638']

        characters = CharactersByStoryFetcher.run(story)

        expect(characters).to be_an(Array)
        expect(characters.first).to be_a(Character)
        expect(characters.first.name).to eq('Sunspot')
      end
    end
  end
end
