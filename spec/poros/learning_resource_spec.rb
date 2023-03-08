require 'rails_helper'

RSpec.describe 'Country Poro' do
  it 'takes in video data, image data, and a country and assigns it to attributes' do
    video_data = {
     snippet: {
        title: 'Nyan Cat'
      },
      id: {
        videoId: '7061726973'
      }
    }
    image_data =  [
      {
        description: 'This is my cat Paris!',
        links: {
          html: 'https://en.wikipedia.org/wiki/Cat#/media/File:Sheba1.JPG'
        }
      },
      {
        description: 'This is my cat Paris!',
        links: {
          html: 'https://en.wikipedia.org/wiki/Cat#/media/File:Sheba1.JPG'
        }
      },
      {
        description: 'This is my cat Paris!',
        links: {
          html: 'https://en.wikipedia.org/wiki/Cat#/media/File:Sheba1.JPG'
        }
      },
      {
        description: 'This is my cat Paris!',
        links: {
          html: 'https://en.wikipedia.org/wiki/Cat#/media/File:Sheba1.JPG'
        }
      },
      {
        description: 'This is my cat Paris!',
        links: {
          html: 'https://en.wikipedia.org/wiki/Cat#/media/File:Sheba1.JPG'
        }
      }
    ]
    country = 'china'

    learning_resource = LearningResource.new(video_data,image_data,country)
    expect(learning_resource.video[:title]).to eq(video_data[:snippet][:title])
    expect(learning_resource.video[:youtube_video_id]).to eq(video_data[:id][:videoId])

    expect(learning_resource.images.count).to eq(image_data.count)
    learning_resource.images.each_with_index do |image, i|
      expect(image[:alt_tag]).to eq(image_data[i][:description])
      expect(image[:url]).to eq(image_data[i][:links][:html])
    end

    expect(learning_resource.country).to eq(country)
  end
end
