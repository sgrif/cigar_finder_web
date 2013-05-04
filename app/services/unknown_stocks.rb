class UnknownStocks
  attr_reader :cigar_store

  def initialize(cigar_store)
    @cigar_store = cigar_store
  end

  def most_popular
    unknown_stocks = CigarSearchLog.all_cigars - cigar_store.known_stocks
    unknown_stocks.first or cigar_store.known_stocks.first
  end
end
