class CountryFacade

  def self.country(country)
    data = CountryService.get_country(country)
    Country.new(data[0])
  end

  def self.random_country_name
    CountryService.get_countries.sample[:name][:common]
  end
end