class ImageService

  def self.get_images_by_country(country)
    response = conn.get("/search/photos?query=#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.unsplash.com') do |f|
      f.params['client_id'] = ENV['unsplash_client_key']
    end
  end
end