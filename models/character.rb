# frozen_string_literal: true

class Character
  attr_reader :id, :name, :image_url

  def initialize(id, name, image_url)
    @id = id
    @name = name
    @image_url = image_url
  end
end
