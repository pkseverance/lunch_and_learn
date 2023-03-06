require 'rails_helper'

RSpec.describe 'Recipe Poro' do
  it 'passes json data into an object' do
    data = {
      label: 'Shrimp Fried Rice',
      country: 'china',
      url: 'https://www.youtube.com/watch?v=eY9DxV-6njw',
      image: 'https://res.cloudinary.com/teepublic/image/private/s--uAttZKh---/c_crop,x_10,y_10/c_fit,h_728/c_crop,g_north_west,h_827,w_1127,x_-172,y_-50/l_misc:transparent_1260/fl_layer_apply,g_north_west,x_-238,y_-262/c_mfit,g_north_east,u_misc:tapestry-l-s-gradient/e_displace,fl_layer_apply,x_0,y_34/l_upload:v1507037315:production:blanks:uue6kkaylik55suzvwsb/fl_layer_apply,g_north_west,x_0,y_0/b_rgb:000000/c_limit,f_auto,h_630,q_90,w_630/v1635405412/production/designs/25191932_0.jpg'
    }
    
    result = Recipe.new(data, 'china')
    
    expect(result.title).to eq(data[:label])
    expect(result.country).to eq(data[:country])
    expect(result.url).to eq(data[:url])
    expect(result.image).to eq(data[:image])
  end
end

