require_relative '../../app/services/unknown_stocks'

class CigarSearchLog; end
class CigarStore; end

describe UnknownStocks do
  let(:cigar_store) { double(:cigar_store, known_stocks: []) }
  let(:unknown_inventory) { described_class.new(cigar_store) }

  it 'gives the most searched for cigar without information' do
    CigarSearchLog.stub(:all_cigars).and_return(['Tatuaje 7th Reserva'])
    unknown_inventory.most_popular.should == 'Tatuaje 7th Reserva'
  end

  it 'does not give cigars that have information' do
    CigarSearchLog.stub(:all_cigars).and_return(['Tatuaje 7th Reserva', 'Illusione Mk'])
    cigar_store.stub(:known_stocks).and_return(['Tatuaje 7th Reserva'])
    unknown_inventory.most_popular.should == 'Illusione Mk'
  end

  it 'gives oldest information as a fallback' do
    CigarSearchLog.stub(:all_cigars).and_return(['Tatuaje 7th Reserva', 'Illusione Mk'])
    cigar_store.stub(:known_stocks).and_return(['Tatuaje 7th Reserva', 'Illusione Mk'])
    unknown_inventory.most_popular.should == 'Tatuaje 7th Reserva'
  end
end
