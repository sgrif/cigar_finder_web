class CigarStore < ActiveRecord::Base
  def self.load_stores(stores)
    stores.map { |store_attributes| where(store_attributes).first_or_create! }
  end
end
