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

  end
end
