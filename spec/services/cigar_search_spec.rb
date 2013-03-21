require_relative '../../app/services/cigar_search'

class CigarStock
end

describe CigarSearch do
  it "searches for stores with a cigar in stock" do
    search = CigarSearch.new('Tatuaje 7th Reserva', %w(Monte's Stag))
    CigarStock.should_receive(:load_stocks).with(["Monte's", 'Stag'], 'Tatuaje 7th Reserva')
    search.results
  end
end
