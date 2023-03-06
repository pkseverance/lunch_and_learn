class CountryService

  def self.get_country(name)
    response = conn.get("/v3.1/name/#{name}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_countries
    response = conn.get('/v3.1/all')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://restcountries.com')
  end
end