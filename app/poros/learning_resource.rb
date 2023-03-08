class LearningResource
  attr_reader :id, :type, :country, :video, :images
  def initialize(video_data, image_data, country)
    @country = country
    @video = {
      title: video_data[:snippet][:title],
      youtube_video_id: video_data[:id][:videoId]
    }
    @images = image_data.map{|data| {alt_tag: data[:description], url: data[:links][:html]}}

  end
end