require_relative '../../app/services/cigar_store_search'
require 'httparty'
require_relative '../../app/services/online_places'

class CigarStore; end

describe CigarStoreSearch do
  before do
    CigarStore.stub(:load_stores) { |stores| stores.map { |attrs| stub(attrs) } }
  end

  let(:here) { stub(latitude: 35.12384, longitude: -106.586094) }
  let(:cigar_store_attrs) { {name: 'Cigar Shop', latitude: 123, longitude: -123} }

  it 'returns the names of stores near a location' do
    OnlinePlaces.stub(:places_near) { [{name: 'Jims'}, {name: 'James'}] }
    CigarStoreSearch.stores_near(here).should == ['Jims', 'James']
  end

  it 'returns all of the store records near a location' do
    stores = [cigar_store_attrs]
    OnlinePlaces.stub(:places_near) { stores }
    CigarStore.should_receive(:load_stores).with(stores)
    CigarStoreSearch.near(here).results
  end

  it 'finds a store in the results from a name' do
    cigar_shop = stub(cigar_store_attrs)
    OnlinePlaces.stub(:places_near) { [cigar_store_attrs] }
    CigarStore.stub(:load_stores).with([cigar_store_attrs]) { [cigar_shop] }
    CigarStoreSearch.near(here).store_named('Cigar Shop').should == cigar_shop
  end
end
