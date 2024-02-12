# frozen_string_literal: true

require_relative 'config/application'
require 'sinatra'
require 'pry'

get '/' do
  begin
    @story = StoryByCharacterFetcher.run(MarvelApiClient::SUNSPOT_CHARACTER_ID)
    @characters = CharactersByStoryFetcher.run(@story)
    erb :home
  rescue StandardError => e
    @error_message = e.message.to_s
    erb :error
  end
end
