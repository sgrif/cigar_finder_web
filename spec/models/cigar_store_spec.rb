require 'spec_helper'

describe CigarStore do
  let(:jims) { {name: 'Jims', latitude: 123, longitude: -123} }
  let(:other_jims) { {name: 'Jims', latitude: 124, longitude: -124} }
  let(:bobs) { {name: 'Bobs', latitude: 1, longitude: -4} }

  it 'remembers stores from their name and location' do
    expect { CigarStore.load_stores([jims]) }.to change(CigarStore, :count).by(1)
  end

  it 'saves new stores to the database' do
    jims_store, bobs_store = CigarStore.create!(jims), CigarStore.create!(bobs)
    expect { @stores = CigarStore.load_stores([jims, bobs]) }.not_to change(CigarStore, :count)
    @stores.should == [jims_store, bobs_store]
  end

  it 'discerns between stores with the same name in different places' do
    expect { CigarStore.load_stores([jims, other_jims]) }.to change(CigarStore, :count).by(2)
  end

  it 'updates any columns that differ besides name, latitude, and longitude' do
    old_attrs = jims.merge(google_details_reference: 'jkl;jkl;')
    store = CigarStore.create!(old_attrs)
    new_attrs = jims.merge(google_details_reference: 'asdfasdf')
    CigarStore.load_stores([new_attrs])
    store.reload.google_details_reference.should == 'asdfasdf'
  end

  it 'only performs one query to load multiple stores' do
    CigarStore.should_receive(:where).with(name: ['Jims', 'Bobs']).once.and_call_original
    CigarStore.load_stores([jims, bobs])
  end

  it 'returns known stocks' do
    CigarStock.stub(:cigars_with_information).and_return(['Tatuaje 7th Reserva'])
    CigarStore.create(name: "Jim's").known_stocks.should == ['Tatuaje 7th Reserva']
  end

  describe '#details_loaded?' do
    subject { cigar_store.details_loaded? }

    context 'store with phone number' do
      let(:cigar_store) { CigarStore.create!(jims.merge(phone_number: '505-850-9255')) }
      it { should be_true }
    end

    context 'store with no phone number' do
      let(:cigar_store) { CigarStore.create!(jims.merge(phone_number: nil)) }
      it { should be_false }
    end
  end
end
