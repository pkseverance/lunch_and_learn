require 'rails_helper'

RSpec.describe 'Learning Resource Service' do
    it 'returns a json response object containing data of videos on the given country' do
      json = File.read('spec/fixtures/learning_resource_service_response.json')
      params = "part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=china&key=#{ENV['google_api_key']}"

      stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?#{params}")
        .to_return(status: 200, body: json, headers: {})

      results = LearningResourceService.find_video_by_country('china')
      expect(results).to be_a(Hash)

      expect(results).to have_key(:items)
      expect(results[:items]).to be_an(Array)

      item = results[:items].first
      expect(item).to have_key(:snippet)
      expect(item[:snippet]).to be_a(Hash)

      expect(item[:snippet]).to have_key(:title)
      expect(item[:snippet][:title]).to be_a(String)

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(Hash)

      expect(item[:id]).to have_key(:videoId)
      expect(item[:id][:videoId]).to be_a(String)
    end
end