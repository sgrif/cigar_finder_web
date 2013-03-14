class CigarStore < ActiveRecord::Base
  def self.load_stores(stores)
    stores.map { |store_attributes| new(store_attributes) }
  end
end
