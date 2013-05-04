require 'spec_helper'

describe CigarStock do
  let(:montes) { CigarStore.create!(name: "Monte's") }
  let(:vcut) { CigarStore.create!(name: 'The V-Cut Cigar Lounge') }
  let(:stag) { CigarStore.create!(name: 'Stag Tobacconist') }

  it 'remembers cigars are carried' do
    CigarStock.save_carried(vcut, 'Tatuaje 7th Reserva')
    CigarStock.cigar_carried?(vcut, 'Tatuaje 7th Reserva').should == true
  end

  it 'remembers cigars are not carried' do
    CigarStock.save_not_carried(stag, 'Liga Privada Feral Flying Pig')
    CigarStock.cigar_carried?(stag, 'Liga Privada Feral Flying Pig').should == false
  end

  it 'loads stocks from a list of stores for a cigar' do
    CigarStock.save_carried(montes, 'Tatuaje 7th Reserva')
    CigarStock.save_not_carried(stag, 'Tatuaje 7th Reserva')
    expected = [CigarStock.first, CigarStock.last]
    CigarStock.load_stocks([montes, stag], 'Tatuaje 7th Reserva').should == expected
  end

  it 'is case insensitive' do
    CigarStock.save_carried(montes, 'Tatuaje Black Petit Lancero')
    CigarStock.cigar_carried?(montes, 'tatuaje black petit lancero').should == true
  end

  describe '#load_stocks' do
    it 'creates new records when loading if none exists' do
      stocks = nil
      expect do
        stocks = CigarStock.load_stocks([montes, vcut], 'Illusione MK4')
      end.to change(CigarStock, :count).by(2)
      stocks.collect(&:carried).should == [nil, nil]
    end

    it 'creates a new record for new cigars' do
      expect { CigarStock.save_carried(montes, 'Tatuaje 7th Reserva') }.to change(CigarStock, :count).by(1)
    end

    it 'modifies existing records when given an already known cigar' do
      CigarStock.save_carried(montes, 'The Mummy')
      expect { CigarStock.save_not_carried(montes, 'The Mummy') }.not_to change(CigarStock, :count)
      CigarStock.cigar_carried?(montes, 'The Mummy').should == false
    end

    it 'only performs one query' do
      cigar = 'Tatuaje Black Petit Lancero'
      CigarStock.save_carried(montes, cigar)
      CigarStock.should_receive(:where).with(cigar_store_id: [montes, vcut], cigar: cigar).once.and_call_original
      cigar_stocks = CigarStock.load_stocks([montes, vcut], cigar)
      cigar_stocks.find { |stock| stock.cigar_store == montes }.carried.should == true
      cigar_stocks.find { |stock| stock.cigar_store == vcut }.carried.should be_nil
    end
  end

  context '.cigars_with_information' do
    before do
      CigarStock.save_carried(1, 'Tatuaje 7th Reserva')
      CigarStock.save_carried(1, 'Illusione Mk')
    end

    it 'gives cigars with information' do
      CigarStock.cigars_with_information.should == ['Tatuaje 7th Reserva', 'Illusione Mk']
    end

    it 'does not give cigars without information' do
      CigarStock.where(cigar: 'Tatuaje 7th Reserva').update_all(carried: nil)
      CigarStock.cigars_with_information.should == ['Illusione Mk']
    end

    it 'gives older information first' do
      CigarStock.create!(cigar_store_id: 1, cigar: 'Tatuaje', carried: true, updated_at: Date.yesterday, created_at: Date.yesterday)
      CigarStock.cigars_with_information.first.should == 'Tatuaje'
    end
  end
end
