class CigarStock < ActiveRecord::Base
  belongs_to :cigar_store

  def self.save_carried(store, cigar)
    where(cigar_store_id: store, cigar: cigar).first_or_initialize.send(:update_carried, true)
  end

  def self.save_not_carried(store, cigar)
    where(cigar_store_id: store, cigar: cigar).first_or_initialize.send(:update_carried, false)
  end

  def self.cigar_carried?(store, cigar)
    record = where(cigar_store_id: store, cigar: cigar).first or raise NoAnswer
    record.carried
  end

  class NoAnswer < RuntimeError; end

  private

  def update_carried(new_carried)
    self.carried = new_carried
    save!
  end
end
