# frozen_string_literal: true

require 'vcr'
require 'rack/test'
require 'webmock/rspec'
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

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.register_request_matcher :ignore_auth_params do |request_one, request_two|
    uri_one = URI.parse(request_one.uri)
    uri_two = URI.parse(request_two.uri)

    uri_one.scheme == uri_two.scheme && uri_one.host == uri_two.host && uri_one.path == uri_two.path
  end
end
