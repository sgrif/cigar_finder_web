class CigarStore < ActiveRecord::Base
  has_many :cigar_stocks

  def self.load_stores(stores_attrs)
    store_names = stores_attrs.collect { |attrs| attrs[:name] }
    cigar_stores = where(name: store_names)
    stores_attrs.map do |attrs|
      matching_attrs_or_create!(attrs, cigar_stores).tap do |store|
        store.update_attributes!(attrs)
      end
    end
  end

  def known_stocks
    cigar_stocks.cigars_with_information
  end

  def details_loaded?
    false
  end

  private

  def self.matching_attrs_or_create!(attrs, cigar_stores)
    existing_store = cigar_stores.find do |cigar_store|
      cigar_store.name == attrs[:name] &&
      cigar_store.latitude == attrs[:latitude] &&
      cigar_store.longitude == attrs[:longitude]
    end
    existing_store or create!(attrs)
  end
end
