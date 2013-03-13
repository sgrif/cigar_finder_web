class OnlinePlaces
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api/place'

  def self.places_near(latitude, longitude, options = {})
    query = default_params.merge(options)
    query.merge!({ key: api_key, location: "#{latitude},#{longitude}" })
    get('/nearbysearch/json', query: query).parsed_response['results']
  end

  private

  def self.default_params
    {
      radius: 20000,
      sensor: false
    }
  end

  def self.api_key
    @api_key ||= ENV.fetch('GOOGLE_API_KEY')
  end
end
