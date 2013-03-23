class CigarStore < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude

  def self.load_stores(stores_attrs)
    store_names = stores_attrs.collect { |attrs| attrs[:name] }
    cigar_stores = where(name: store_names)
    stores_attrs.map do |attrs|
      matching_attrs_or_create!(attrs, cigar_stores)
    end
  end

  private

  def self.matching_attrs_or_create!(attrs, cigar_stores)
    existing_store = cigar_stores.find do |cigar_store|
      cigar_store.attributes.merge(attrs.stringify_keys) == cigar_store.attributes
    end
    existing_store or create!(attrs)
  end
end
