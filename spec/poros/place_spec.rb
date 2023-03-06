require 'rails_helper'

RSpec.describe 'Place Poro' do
  it 'takes in place data and assigns it to attributes' do
    data = {
      properties: {
        name: 'test',
        formatted: '1234 56 St. City, State',
        place_id: '3.243F6A8885A308D3069E'
      }
    }

    place = Place.new(data)

    expect(place.name).to eq(data[:properties][:name])
    expect(place.address).to eq(data[:properties][:formatted])
    expect(place.place_id).to eq(data[:properties][:place_id])
  end
end