require_relative '../../app/services/cigar_search'
require_relative '../../app/services/cigar_search_result'

class CigarStock
  class NoAnswer < RuntimeError; end
end

describe CigarSearch do
  before do
    CigarStock.stub(:search_records).and_yield
  end

  it "searches for stores with a cigar in stock" do
    search = CigarSearch.new('Tatuaje 7th Reserva', %w(Monte's Stag))
    CigarStock.stub(:cigar_carried?).with("Monte's", 'Tatuaje 7th Reserva') { true }
    CigarStock.stub(:cigar_carried?).with('Stag', 'Tatuaje 7th Reserva') { false }

    search.results.find { |result| result.store == "Monte's" }.carried.should == true
    search.results.find { |result| result.store == 'Stag'}.carried.should == false
  end

  it "tells me if a store has no data" do
    search = CigarSearch.new('Really Obscure Cigar', ['Jims Cigars'])
    CigarStock.stub(:cigar_carried?).with('Jims Cigars', 'Really Obscure Cigar').and_raise(CigarStock::NoAnswer)

    search.results.first.carried.should == CigarSearch::NoAnswer
  end
end
