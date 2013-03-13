class CigarSearch
  attr_reader :cigar, :stores

  def initialize(cigar, stores)
    @cigar, @stores = cigar, stores
  end

  def results
    @results ||= stores.map do |store|
      carried = begin
                  CigarStock.cigar_carried?(store, cigar)
                rescue CigarStock::NoAnswer
                  NoAnswer
                end
      CigarSearchResult.new(store, carried)
    end
  end

  class NoAnswer; end
end
