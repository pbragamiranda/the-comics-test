# frozen_string_literal: true

require_relative 'config/application'
require 'sinatra'

get '/' do
  marvel_api_service = MarvelApiService.new
  @story = marvel_api_service.fetch_random_story_by_character(MarvelApiService::SUNSPOT_CHARACTER_ID)
  @characters = marvel_api_service.fetch_story_characters(@story)
  erb :home
end
