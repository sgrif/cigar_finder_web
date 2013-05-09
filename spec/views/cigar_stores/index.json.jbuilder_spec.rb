require 'spec_helper'

describe 'cigar_stores/index' do
  let(:cigar_store) { {
    id: nil,
    name: "Jim's Cigars",
    address: '100 Main Street',
    latitude: 3.0,
    longitude: 4.0
  } }

  it 'displays the search results' do
    assign(:cigar_stores, [stub_model(CigarStore, cigar_store.merge(google_details_reference: 'asdfasdklfjasdf'))])
    render
    rendered.should == [cigar_store].to_json
  end
end
