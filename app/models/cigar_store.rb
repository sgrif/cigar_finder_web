class CigarStore < ActiveRecord::Base
  has_many :cigar_stocks

  def self.load_stores(stores_attrs)
    store_names = stores_attrs.collect { |attrs| attrs[:name] }
    cigar_stores = where(name: store_names)
    stores_attrs.map do |attrs|
      matching_attrs_or_create!(attrs, cigar_stores)
    end
  end

  def known_stocks
    cigar_stocks.cigars_with_information
  end

  def details_loaded?
    phone_number.present?
  end

  def save_details(details)
    update_attributes!(details)
  end

  private

  def self.matching_attrs_or_create!(attrs, cigar_stores)
    existing_store = matching_attrs(attrs, cigar_stores)
    if existing_store
      existing_store.tap { existing_store.update_attributes!(attrs) }
    else
      create!(attrs)
    end
  end

  def self.matching_attrs(attrs, cigar_stores)
    cigar_stores.find do |cigar_store|
      cigar_store.name == attrs[:name] &&
      similar_float?(cigar_store.latitude, attrs[:latitude])
      similar_float?(cigar_store.longitude, attrs[:longitude])
    end
  end

  def self.similar_float?(float, other)
    (float * 1000).round == (other * 1000).round
  end
end
