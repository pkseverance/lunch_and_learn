class CountryFacade

  def self.country(country)
    data = CountryService.get_country(country)
    Country.new(data[0])
  end

  #Ignore this. It's part of the main project and I don't have tests for it yet.
  def self.random_country_name
    CountryService.get_countries.sample[:name][:common]
  end
end