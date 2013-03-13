class CigarStoreSearch
  attr_reader :location

  def self.stores_near(location)
    new(location).results.map { |place| place['name'] }
  end

  def initialize(location)
    @location = location
  end

  def results
    OnlinePlaces.places_near(location.latitude, location.longitude, keyword: 'cigar')
  end
end
