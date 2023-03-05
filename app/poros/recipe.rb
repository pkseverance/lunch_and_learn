class Recipe
  attr_reader :id, :title, :url, :image, :type, :country
  def initialize(data, country)
    @title = data[:recipe][:label]
    @url = data[:recipe][:url]
    @image = data[:recipe][:image]
    @country = country
  end
end