class StoreDetails
  def self.load_needed(stores)
    stores.reject(&:details_loaded?).map do |store|
      new(store.id).load
    end
  end

  attr_reader :store_id

  def initialize(store_id)
    @store_id = store_id
  end

  def load
    store.save_details(OnlinePlaceDetails.for(reference))
  end

  private

  def reference
    store.google_details_reference
  end

  def store
    @store ||= CigarStore.find(store_id)
  end
end
