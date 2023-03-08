require 'rails_helper'

RSpec.describe 'Learning Resources Request' do
  it 'returns json response object containing video and image data for learning resources of the given country' do
    json_1 = File.read('spec/fixtures/image_service_response.json')
      params_1 ="query=china&client_id=#{ENV['unsplash_client_key']}"

      stub_request(:get, "https://api.unsplash.com/search/photos?#{params_1}")
        .to_return(status: 200, body: json_1, headers: {})

    json_2 = File.read('spec/fixtures/learning_resource_service_response.json')
      params_2 = "part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw&q=china&key=#{ENV['google_api_key']}"

      stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?#{params_2}")
        .to_return(status: 200, body: json_2, headers: {})

    get '/api/v1/learning_resources?country=china'
    expect(response).to(be_successful)

    learning_resource = JSON.parse(response.body, symbolize_names: true)
    expect(learning_resource).to be_a(Hash)

    expect(learning_resource[:data]).to have_key(:id)
    expect(learning_resource[:data][:id]).to eq(nil)

    expect(learning_resource[:data]).to have_key(:type)
    expect(learning_resource[:data][:type]).to eq('learning_resource')

    expect(learning_resource[:data]).to have_key(:attributes)
    expect(learning_resource[:data][:attributes]).to be_a(Hash)

    expect(learning_resource[:data][:attributes]).to have_key(:country)
    expect(learning_resource[:data][:attributes][:country]).to eq('china')

    expect(learning_resource[:data][:attributes]).to have_key(:video)
    expect(learning_resource[:data][:attributes][:video]).to be_a(Hash)

    expect(learning_resource[:data][:attributes][:video]).to have_key(:title)
    expect(learning_resource[:data][:attributes][:video][:title]).to be_a(String)

    expect(learning_resource[:data][:attributes][:video]).to have_key(:youtube_video_id)
    expect(learning_resource[:data][:attributes][:video][:youtube_video_id]).to be_a(String)

    expect(learning_resource[:data][:attributes]).to have_key(:images)
    expect(learning_resource[:data][:attributes][:images]).to be_an(Array)

    learning_resource[:data][:attributes][:images].each do |image|
      expect(image).to be_a(Hash)

      expect(image).to have_key(:alt_tag)
      expect(image[:alt_tag]).to be_a(String).or(eq(nil))

      expect(image).to have_key(:url)
      expect(image[:url]).to be_a(String)
    end


  end
end