class Api::V1::CountriesController < ApplicationController
  def search
    country = CountryFacade.country(params[:country])
    places = PlaceFacade.tourism_near_coords(country.capital_coords)
    render json: TouristSightSerializer.new(places)
  end
end