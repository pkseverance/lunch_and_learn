require 'rails_helper'

RSpec.describe 'Learning Resource Facade' do
    it 'creates a learning resource object out of data from services' do
      json_1 = File.read('spec/fixtures/image_service_response.json')
      params_1 ="query=china&client_id=#{ENV['unsplash_client_key']}"

      stub_request(:get, "https://api.unsplash.com/search/photos?#{params_1}")
        .to_return(status: 200, body: json_1, headers: {})

    json_2 = File.read('spec/fixtures/learning_resource_service_response.json')
      params_2 = "part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=china&key=#{ENV['google_api_key']}"

      stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?#{params_2}")
        .to_return(status: 200, body: json_2, headers: {})
    learning_resource = LearningResourceFacade.learning_resource('china')

    expect(learning_resource).to be_a(LearningResource)
  end
end