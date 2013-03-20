class CigarStock < ActiveRecord::Base
  belongs_to :cigar_store

  def self.save_carried(store, cigar)
    where(cigar_store_id: store, cigar: cigar.downcase).first_or_initialize.send(:update_carried, true)
  end

  def self.save_not_carried(store, cigar)
    where(cigar_store_id: store, cigar: cigar.downcase).first_or_initialize.send(:update_carried, false)
  end

  def self.cigar_carried?(store, cigar)
    record = find_record(store, cigar) or raise NoAnswer
    record.carried
  end

  def self.search_records(stores, cigar)
    @records_to_search = where(cigar_store_id: stores.to_a, cigar: cigar.downcase)
    yield
  ensure
    @records_to_search = nil
  end

  class NoAnswer < RuntimeError; end

  private

  def self.find_record(store, cigar)
    return where(cigar_store_id: store, cigar: cigar.downcase).first unless @records_to_search
    @records_to_search.find { |record| record.cigar_store_id == store.id }
  end

  def update_carried(new_carried)
    self.carried = new_carried
    save!
  end
end
