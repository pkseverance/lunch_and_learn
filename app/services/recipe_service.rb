class RecipeService
  def self.get_recipe_by_country(country)
    response = conn.get("/api/recipes/v2?type=public&q=#{country}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://api.edamam.com') do |f|
      f.params['app_key'] = ENV['edamam_search_api_key']
      f.params['app_id'] = ENV['edamam_search_api_id']
    end
  end
end