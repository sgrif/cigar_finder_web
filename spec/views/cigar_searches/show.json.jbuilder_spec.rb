require 'spec_helper'

describe 'cigar_searches/show' do
  let(:cigar_store) { { name: "Jim's Cigars", latitude: 3, longitude: 4 } }

  it 'displays the cigar that was searched' do
    assign(:cigar, 'Tatuaje Black Petit Lancero')
    assign(:search_results, [])

    render

    rendered.should == {cigar: 'Tatuaje Black Petit Lancero', results: []}.to_json
  end

  it 'displays the search results flattened' do
    assign(:search_results, [stub(store: stub_model(CigarStore, cigar_store), carried: true)])
    render
    rendered.should == {cigar: nil, results: [{store: "Jim's Cigars", latitude: 3.0, longitude: 4.0, carried: true}]}.to_json
  end

  it 'displays nil for CigarSearch::NoAnswer' do
    assign(:search_results, [stub(store: stub_model(CigarStore, cigar_store), carried: CigarSearch::NoAnswer)])
    render
    rendered.should == {cigar: nil, results: [{store: "Jim's Cigars", latitude: 3.0, longitude: 4.0, carried: nil}]}.to_json
  end
end
