# frozen_string_literal: true

# Require gems
require 'json'
require 'open-uri'
require 'digest/md5'
require 'dotenv/load'

# Load all models
Dir["#{__dir__}/../models/*.rb"].sort.each { |file| require file }
# Load all services
Dir["#{__dir__}/../services/*.rb"].sort.each { |file| require file }
