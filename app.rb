# frozen_string_literal: true

require_relative 'config/application'
require 'sinatra'

get '/' do
  @story = StoryByCharacterFetcher.run(MarvelApiClient::SUNSPOT_CHARACTER_ID)
  @characters = CharactersByStoryFetcher.run(@story)
  erb :home
end
