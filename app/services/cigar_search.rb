class CigarSearch
  attr_reader :cigar, :stores

  def initialize(cigar, stores)
    @cigar, @stores = cigar, stores
  end

  def results
    @results ||= CigarStock.search_records(stores, cigar) { load_results }
  end

  class NoAnswer; end

  private

  def load_results
    stores.map do |store|
      carried = begin
                  CigarStock.cigar_carried?(store, cigar)
                rescue CigarStock::NoAnswer
                  NoAnswer
                end
      CigarSearchResult.new(store, cigar, carried)
    end
  end
end
