require 'rails_helper'

RSpec.describe 'Country Facade' do
    it 'creates a country object out of data from service' do
      json = File.read('spec/fixtures/country_service_get_country_response.json')

      stub_request(:get, 'https://restcountries.com/v3.1/name/japan')
        .to_return(status: 200, body: json, headers: {})

    country = CountryFacade.country('japan')

    expect(country).to be_a(Country)
  end
end
