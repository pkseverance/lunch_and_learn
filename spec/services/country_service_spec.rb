require 'rails_helper'

RSpec.describe 'Country Service' do
  it 'returns a json response object containing a list of all countries' do
    response = File.read('spec/fixtures/country_service_response.json')
      stub_request(:get, 'https://restcountries.com/v3.1/all')
        .to_return(status: 200, body: response, headers: {})
  
    results = CountryService.get_countries
    expect(results).to be_an(Array)
    results.each do |result|
      expect(result).to have_key(:name)
      expect(result[:name]).to be_a(Hash)
      expect(result[:name]).to have_key(:common)
      expect(result[:name][:common]).to be_a(String)
    end
  end

  it 'returns a json response object containing data on a specific country' do
    json_1 = File.read('spec/fixtures/country_service_get_country_response.json')

    stub_request(:get, 'https://restcountries.com/v3.1/name/japan')
      .to_return(status: 200, body: json_1, headers: {})

    results = CountryService.get_country('japan')
    expect(results).to be_an(Array)

    result = results[0]
    expect(result).to have_key(:name)
    expect(result[:name]).to be_a(Hash)
    expect(result[:name]).to have_key(:common)
    expect(result[:name][:common]).to be_a(String)

    expect(result).to have_key(:capitalInfo)
    expect(result[:capitalInfo]).to be_a(Hash)

    expect(result[:capitalInfo]).to have_key(:latlng)
    expect(result[:capitalInfo][:latlng]).to be_an(Array)
  end
end
