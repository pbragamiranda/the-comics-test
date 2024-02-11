# frozen_string_literal: true

require 'rack/test'
require_relative '../models/story'
require_relative '../models/character'
require_relative '../services/marvel_api_service'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def app
  Sinatra::Application
end
