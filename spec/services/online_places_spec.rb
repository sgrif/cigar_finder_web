require 'httparty'
require_relative '../../app/services/online_places'
require 'vcr_helper'
require 'geocoder'

describe OnlinePlaces do
  let(:home) { Geocoder.search('100 Central SW Albuquerque NM').first }

  it 'returns relevant places first' do
    VCR.use_cassette 'stores-are-relevant' do
      places = OnlinePlaces.places_near(home.latitude, home.longitude, keyword: 'cigar')
      jake_and_harleys_index = places.index { |place| place[:name] == 'Jake & Harleys cigar gallery and Smoking Lounge' }
      hookah_kings_index = places.index { |place| place[:name] == 'Hookah Kings' }
      jake_and_harleys_index.should be < hookah_kings_index
    end
  end

  it 'returns name, latitude, longitutde, and address' do
    VCR.use_cassette 'movies-downtown-albuquerque' do
      places = OnlinePlaces.places_near(home.latitude, home.longitude, keyword: 'movies', rankby: 'distance')
      expected = {
        name: 'Cinemark 14 Downtown',
        latitude: 35.084046,
        longitude: -106.648623,
        address: '100 Central Avenue Southwest, Albuquerque'
      }
      places.first.should == expected
    end
  end

  it 'should not pass a radius when rankby is set to distance' do
    VCR.use_cassette 'rank-by-distance' do
      OnlinePlaces.stub(:get) do |url, args|
        @request_query = args[:query]
        HTTParty.get(OnlinePlaces.base_uri + url, args)
      end
      OnlinePlaces.places_near(home.latitude, home.longitude, keyword: 'stores', rankby: 'distance')
      @request_query[:radius].should_not be_present
    end
  end
end
