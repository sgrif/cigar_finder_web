class CigarSearch
  attr_reader :cigar, :stores

  def initialize(cigar, stores)
    @cigar, @stores = cigar, stores
  end

  def results
    @results ||= CigarStock.load_stocks(stores, cigar)
  end

  def log_search(ip)
    CigarSearchLog.log_search(ip, @cigar)
  end
end
