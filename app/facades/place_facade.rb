class PlaceFacade
  def self.tourism_near_coords(coords)
    response = PlacesService.get_places_by_coords(coords)
    response[:features].map {|data| Place.new(data)}
  end
end