class CigarStock < ActiveRecord::Base
  belongs_to :cigar_store

  def self.save_carried(store, cigar)
    where(cigar_store_id: store, cigar: cigar.titleize).first_or_initialize.tap do |result|
      result.send(:update_carried, true)
    end
  end

  def self.save_not_carried(store, cigar)
    where(cigar_store_id: store, cigar: cigar.titleize).first_or_initialize.tap do |result|
      result.send(:update_carried, false)
    end
  end

  def self.load_stocks(stores, cigar)
    cigar_name = cigar.titleize
    cigar_stocks = where(cigar_store_id: stores.to_a, cigar: cigar_name).to_a
    stores.map { |cigar_store| load_stock(cigar_stocks, cigar_store, cigar_name) }
  end

  def self.cigar_carried?(cigar_store, cigar)
    where(cigar_store_id: cigar_store, cigar: cigar.titleize).first_or_create!.carried
  end

  def self.cigars_with_information
    where.not(carried: nil).order(:updated_at).pluck(:cigar)
  end

  def self.for(cigar_store, cigar)
    stocks = where(cigar_store: cigar_store, cigar: cigar)
    load_stock(stocks, cigar_store, cigar)
  end

  private

  def self.load_stock(cigar_stocks, cigar_store, cigar_name)
    existing_record = cigar_stocks.find { |stock| stock.cigar_store_id == cigar_store.id }
    (existing_record or create!(cigar_store: cigar_store, cigar: cigar_name, carried: nil)).tap do |cigar_stock|
      cigar_stock.cigar_store = cigar_store # Prevent additional query to load store
    end
  end

  def update_carried(new_carried)
    self.carried = new_carried
    save! and touch
  end
end
