class CigarStoreSearch
  class StoreNotFound < RuntimeError; end
  include Enumerable

  delegate :each, to: :results

  attr_reader :latitude, :longitude

  def self.near(location)
    new(location.latitude, location.longitude)
  end

  def initialize(latitude, longitude)
    @latitude, @longitude = latitude, longitude
  end

  def store_named(store_name)
    find { |store| store.name == store_name } or raise(StoreNotFound)
  end

  private

  def results
    @results ||= load_results
  end

  def load_results
    places = OnlinePlaces.places_near(latitude, longitude, keyword: 'cigar')
    CigarStore.load_stores(places)
  end
end
