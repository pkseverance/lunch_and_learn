class Recipe
  attr_reader :id, :type, :title, :url, :image, :country
  def initialize(data, country)
    @title = data[:label]
    @url = data[:url]
    @image = data[:image]
    @country = country
  end
end