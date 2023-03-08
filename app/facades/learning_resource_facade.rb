class LearningResourceFacade
  def self.learning_resource(country)
    video_response = LearningResourceService.find_video_by_country(country)
    video_data = video_response[:items].first

    image_response = ImageService.get_images_by_country(country)
    image_data = image_response[:results]
    LearningResource.new(video_data, image_data, country)
  end
end