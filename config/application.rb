# frozen_string_literal: true

# Load all models
Dir["#{__dir__}/../models/*.rb"].sort.each { |file| require file }
