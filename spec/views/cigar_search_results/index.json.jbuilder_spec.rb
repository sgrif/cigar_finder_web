require 'spec_helper'

describe 'cigar_search_results/index' do
  let(:cigar_store) { { id: nil, name: "Jim's Cigars", latitude: 3.0, longitude: 4.0 } }

  it 'displays the search results' do
    assign(:search_results, [stub(store: stub_model(CigarStore, cigar_store), cigar: 'Tatuaje 7th Reserva', carried: true)])
    render
    rendered.should == {cigar_search_results: [{cigar_store: cigar_store, cigar: 'Tatuaje 7th Reserva', carried: true}]}.to_json
  end

  it 'displays nil for CigarSearch::NoAnswer' do
    assign(:search_results, [stub(store: stub_model(CigarStore, cigar_store), cigar: "Larry's Bundle", carried: CigarSearch::NoAnswer)])
    render
    rendered.should == {cigar_search_results: [{cigar_store: cigar_store, cigar: "Larry's Bundle", carried: nil}]}.to_json
  end
end
