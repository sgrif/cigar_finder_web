require_relative '../../app/services/cigar_search'

class CigarStock; end
class CigarSearchLog; end

describe CigarSearch do
  it "searches for stores with a cigar in stock" do
    search = CigarSearch.new('Tatuaje 7th Reserva', %w(Monte's Stag))
    CigarStock.should_receive(:load_stocks).with(["Monte's", 'Stag'], 'Tatuaje 7th Reserva')
    search.results
  end

  it "logs the search" do
    CigarSearchLog.should_receive(:log_search).with('127.0.0.1', 'Illusione MK Ultra')
    search = CigarSearch.new('Illusione MK Ultra', ['Rio Rancho Cigars'])
    search.log_search('127.0.0.1')
  end
end
