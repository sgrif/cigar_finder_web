class OnlinePlaceDetails
  include HTTParty
  base_uri 'https://maps.googleapis.com/maps/api/place'

  def self.for(reference)
    new(reference).load
  end

  attr_reader :reference

  def initialize(reference)
    @reference = reference
  end

  def load
    {
      phone_number: raw_results['formatted_phone_number']
    }
  end

  private

  def raw_results
    @raw_results ||= self.class.get('/details/json', query: query).parsed_response['result']
  end

  def query
    {
      key: OnlinePlaces::API_KEY,
      sensor: false,
      reference: reference
    }
  end
end
