class CigarStoreSearch
  class StoreNotFound < RuntimeError; end

  attr_reader :location

  def self.near(location)
    new(location)
  end

  def initialize(location)
    @location = location
  end

  def results
    @results ||= load_results
  end

  def store_named(store_name)
    results.find { |store| store.name == store_name } or raise(StoreNotFound)
  end

  protected

  def load_results
    places = OnlinePlaces.places_near(location.latitude, location.longitude, keyword: 'cigar')
    CigarStore.load_stores(places)
  end
end
