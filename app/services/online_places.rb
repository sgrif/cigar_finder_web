class OnlinePlaces
  API_KEY = ENV['GOOGLE_API_KEY']

  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api/place'
  attr_reader :query

  def self.places_near(latitude, longitude, options = {})
    new(latitude, longitude, options).results
  end

  def initialize(latitude, longitude, options = {})
    @query = default_params.merge(options)
    @query.delete(:radius) if @query[:rankby] == 'distance'
    @query.merge!({ key: API_KEY, location: "#{latitude},#{longitude}" })
  end

  def results
    @results ||= parse_results
  end

  private

  def parse_results
    raw_results.map do |place|
      {
        name: place['name'],
        latitude: place['geometry']['location']['lat'],
        longitude: place['geometry']['location']['lng'],
        address: place['vicinity'],
        google_details_reference: place['reference']
      }
    end
  end

  def raw_results
    @raw_results ||= self.class.get('/nearbysearch/json', query: query).parsed_response['results']
  end

  def default_params
    {
      radius: 20000,
      sensor: false
    }
  end
end
