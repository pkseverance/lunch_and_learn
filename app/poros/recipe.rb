class Recipe
  attr_reader :id, :title, :url, :image, :type, :country
  def initialize(data, country)
    @title = data[:label]
    @url = data[:url]
    @image = data[:image]
    @country = country
  end
end