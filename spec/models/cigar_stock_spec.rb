require 'spec_helper'

describe CigarStock do
  let(:montes) { CigarStore.create!(name: "Monte's") }
  let(:vcut) { CigarStore.create!(name: 'The V-Cut Cigar Lounge') }

  it 'remembers cigars are carried' do
    CigarStock.save_carried(vcut, 'Tatuaje 7th Reserva')
    CigarStock.cigar_carried?(vcut, 'Tatuaje 7th Reserva').should be_true
  end

  it 'remembers cigars are not carried' do
    stag = CigarStore.create!(name: 'Stag Tobacconist')
    CigarStock.save_not_carried(stag, 'Liga Privada Feral Flying Pig')
    CigarStock.cigar_carried?(stag, 'Liga Privada Feral Flying Pig').should be_false
  end

  it "raises an exception if it can't find a cigar" do
    obscure_store = CigarStore.create!(name: 'Very Obscure Shop')
    expect { CigarStock.cigar_carried?(obscure_store, 'Some Magic Cigar') }.to raise_exception(CigarStock::NoAnswer)
  end

  it 'creates a new record for new cigars' do
    expect { CigarStock.save_carried(montes, 'Tatuaje 7th Reserva') }.to change(CigarStock, :count).by(1)
  end

  it 'modifies existing records when given an already known cigar' do
    CigarStock.save_carried(montes, 'The Mummy')
    expect { CigarStock.save_not_carried(montes, 'The Mummy') }.not_to change(CigarStock, :count)
    CigarStock.cigar_carried?(montes, 'The Mummy').should be_false
  end

  it 'only performs one query' do
    cigar = 'Tatuaje Black Petit Lancero'
    CigarStock.save_carried(montes, cigar)
    CigarStock.should_receive(:where).with(cigar_store_id: [montes, vcut], cigar: cigar).once.and_call_original
    CigarStock.search_records([montes, vcut], cigar) do
      CigarStock.cigar_carried?(montes, cigar).should be_true
      expect { CigarStock.cigar_carried?(vcut, cigar) }.to raise_exception(CigarStock::NoAnswer)
    end
  end
end
