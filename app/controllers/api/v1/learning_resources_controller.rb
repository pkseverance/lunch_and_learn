class Api::V1::LearningResourcesController < ApplicationController
  def index
    country = params[:country]
    learning_resource = LearningResourceFacade.learning_resource(country)
    render json: LearningResourceSerializer.new(learning_resource)
  end
end