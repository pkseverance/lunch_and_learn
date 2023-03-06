class Country
  attr_reader :name, :capital_coords

  def initialize(data)
    @name = data[:name][:common]
    @capital_coords = data[:capitalInfo][:latlng]
  end
end