require_relative '../../app/services/cigar_store_search'
require 'httparty'
require_relative '../../app/services/online_places'

describe CigarStoreSearch do
  let(:here) { stub(latitude: 35.12384, longitude: -106.586094) }

  it 'returns the names of stores near a location' do
    OnlinePlaces.stub(:places_near) { [{'name' => 'Jims'}, {'name' => 'James'}] }
    CigarStoreSearch.stores_near(here).should == ['Jims', 'James']
  end
end
