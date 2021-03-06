require 'active_support/core_ext'
require_relative '../../app/services/cigar_store_search'
require 'httparty'
require_relative '../../app/services/online_places'
require_relative '../../app/services/store_details'

class CigarStore; end

describe CigarStoreSearch do
  before do
    CigarStore.stub(:load_stores) { |stores| stores.map { |attrs| double(attrs) } }
    StoreDetails.stub(:load_needed)
  end

  let(:here) { double(latitude: 35.12384, longitude: -106.586094) }
  let(:cigar_store_attrs) { {name: 'Cigar Shop', latitude: 123, longitude: -123} }

  it 'returns all of the store records near a location' do
    stores = [cigar_store_attrs]
    OnlinePlaces.stub(:places_near) { stores }
    CigarStore.should_receive(:load_stores).with(stores)
    CigarStoreSearch.near(here).find{}
  end

  it 'finds a store in the results from a name' do
    cigar_shop = double(cigar_store_attrs)
    OnlinePlaces.stub(:places_near) { [cigar_store_attrs] }
    CigarStore.stub(:load_stores).with([cigar_store_attrs]) { [cigar_shop] }
    CigarStoreSearch.near(here).store_named('Cigar Shop').should == cigar_shop
  end

  it 'raises an exception if no store has that name' do
    OnlinePlaces.stub(:places_near)
    CigarStore.stub(:load_stores) { [] }
    expect { CigarStoreSearch.near(here).store_named('Not Real') }.to raise_exception(CigarStoreSearch::StoreNotFound)
  end

  it 'loads the details of stores' do
    OnlinePlaces.stub(:places_near) { [cigar_store_attrs] }
    StoreDetails.should_receive(:load_needed)
    CigarStoreSearch.near(here).find{}
  end
end
