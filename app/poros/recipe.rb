class Recipe
  attr_reader :title, :url, :image, :id, :type, :country
  def initialize(data)
    @title = data[:recipe][:label]
    @url = data[:recipe][:url]
    @image = data[:recipe][:image]
  end
end