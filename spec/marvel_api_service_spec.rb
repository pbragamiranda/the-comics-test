# frozen_string_literal: true

require 'spec_helper'

describe MarvelApiService do
  describe '#fetch_random_story_by_character' do
    it 'fetches a random story by character and returns a Story object' do
      VCR.use_cassette('fetch_random_story_by_character', match_requests_on: %i[method ignore_auth_params]) do
        marvel_api = MarvelApiService.new
        story = marvel_api.fetch_random_story_by_character(MarvelApiService::SUNSPOT_CHARACTER_ID)

        expect(story).to be_a(Story)
        expect(story.title).to be_a(String)
        expect(story.description).to be_a(String)
        expect(story.characters_ids).to include(MarvelApiService::SUNSPOT_CHARACTER_ID)
      end
    end
  end

  describe '#fetch_story_characters' do
    it 'fetches characters for a given story and returns an array of Character objects' do
      VCR.use_cassette('fetch_story_characters', match_requests_on: %i[method ignore_auth_params]) do
        marvel_api = MarvelApiService.new
        story = Story.new('name', 'description')
        story.characters_ids = ['1009638']

        characters = marvel_api.fetch_story_characters(story)

        expect(characters).to be_an(Array)
        expect(characters.first).to be_a(Character)
        expect(characters.first.name).to eq('Sunspot')
      end
    end
  end
end
