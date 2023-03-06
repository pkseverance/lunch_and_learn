require 'rails_helper'

RSpec.describe 'Country Poro' do
  it 'takes in country data and assigns it to attributes' do
    data = {
      name: {
        common: 'Japan'
      },
      capitalInfo: {
        latlng: [35.68,139.75]
      }
    }

    country = Country.new(data)
    expect(country.name).to eq(data[:name][:common])
    expect(country.capital_coords).to eq(data[:capitalInfo][:latlng])
  end
end
