require 'httparty'
require_relative '../../app/services/online_places'
require 'vcr_helper'
require 'geocoder'

describe OnlinePlaces do
  it 'should return relevant nearby places' do
    VCR.use_cassette('nearby-restaurants-downtown') do
      home = Geocoder.search('100 Silver SW Albuquerque NM').first
      places = OnlinePlaces.places_near(home.latitude, home.longitude, keyword: 'restaurant')
      standard_diner_index = places.index { |place| place['name'] == 'Standard Diner' }
      frontier_index = places.index { |place| place['name'] == 'Frontier Restaurant' }
      standard_diner_index.should be < frontier_index
    end
  end

  it 'returns relevant places first' do
    VCR.use_cassette 'stores-are-relevant' do
      home = Geocoder.search('100 Silver SW Albuquerque NM').first
      places = OnlinePlaces.places_near(home.latitude, home.longitude, keyword: 'cigar')
      jake_and_harleys_index = places.index { |place| place['name'] == 'Jake & Harleys cigar gallery and Smoking Lounge' }
      hookah_kings_index = places.index { |place| place['name'] == 'Hookah Kings' }
      jake_and_harleys_index.should be < hookah_kings_index
    end
  end
end
