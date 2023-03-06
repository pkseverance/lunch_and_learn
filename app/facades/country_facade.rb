class CountryFacade
  def self.random_country_name
    CountryService.get_countries.sample[:name][:common]
  end
end