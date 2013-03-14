class CigarStoreSearch
  attr_reader :location

  def self.stores_near(location)
    near(location).results.map { |place| place[:name] }
  end

  def self.near(location)
    new(location)
  end

  def initialize(location)
    @location = location
  end

  def results
    @results ||= load_results
  end

  protected

  def load_results
    OnlinePlaces.places_near(location.latitude, location.longitude, keyword: 'cigar')
  end
end
