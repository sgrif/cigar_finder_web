require 'spec_helper'

describe 'cigar_search_results/index' do
  let(:cigar_store) { {
    id: nil,
    name: "Jim's Cigars",
    latitude: 3.0,
    longitude: 4.0,
    address: '100 Main Street'
  } }

  it 'displays the search results' do
    assign(:search_results, [stub_model(CigarStock,
      cigar_store: stub_model(CigarStore, cigar_store),
      cigar: 'Tatuaje 7th Reserva',
      carried: true)])
    render
    rendered.should == [{cigar_store: cigar_store, cigar: 'Tatuaje 7th Reserva', carried: true, updated_at: nil}].to_json
  end
end
