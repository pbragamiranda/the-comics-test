# frozen_string_literal: true

# Load all models
Dir["#{__dir__}/../models/*.rb"].each { |file| require file }
# Load all services
Dir["#{__dir__}/../services/*.rb"].each { |file| require file }
