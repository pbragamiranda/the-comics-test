# frozen_string_literal: true

# Load all models
Dir["#{__dir__}/../models/*.rb"].sort.each { |file| require file }
# Load all services
Dir["#{__dir__}/../services/*.rb"].sort.each { |file| require file }
