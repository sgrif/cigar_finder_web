require 'spec_helper'

describe CigarStore do
  let(:store_attrs) { {name: 'Jims', latitude: 123, longitude: -123} }

  it 'remembers stores from their name and location' do
    expect { CigarStore.load_stores([store_attrs]) }.to change(CigarStore, :count).by(1)
  end

  it 'saves new stores to the database' do
    store = CigarStore.create!(store_attrs)
    expect { @stores = CigarStore.load_stores([store_attrs]) }.not_to change(CigarStore, :count)
    @stores.should == [store]
  end
end
