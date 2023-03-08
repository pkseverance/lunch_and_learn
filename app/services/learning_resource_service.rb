class LearningResourceService
  def self.find_video_by_country(country)
    channel_id = 'UCluQ5yInbeAkkeCndNnUhpw'
    response = conn.get("/youtube/v3/search?part=snippet&channelId=#{channel_id}&q=#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def self.conn
    Faraday.new(url: 'https://youtube.googleapis.com') do |f|
      f.params['key'] = ENV['google_api_key']
    end
  end
end

