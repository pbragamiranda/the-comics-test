# frozen_string_literal: true

class Story
  attr_accessor :characters_ids
  attr_reader :title, :description

  def initialize(title, description)
    @title = title
    @description = sanitize_description(description)
    @characters_ids = []
  end

  private

  def sanitize_description(description)
    description.empty? ? 'No description available.' : description
  end
end
