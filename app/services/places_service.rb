class PlacesService

  def self.get_places_by_coords(coords)
    response = conn.get("/v2/places?categories=tourism.attraction&filter=circle:#{coords[1]},#{coords[0]},1000")
    JSON.parse(response.body, symbolize_names: true)
  end


  def self.conn
    Faraday.new(url: 'https://api.geoapify.com') do |f|
      f.params['apiKey'] = ENV['places_api_key']
    end
  end
end