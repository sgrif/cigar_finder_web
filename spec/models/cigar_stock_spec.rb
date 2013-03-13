require 'spec_helper'

describe CigarStock do
  it 'remembers cigars are carried' do
    CigarStock.save_carried('The V-Cut Cigar Lounge', 'Tatuaje 7th Reserva')
    CigarStock.cigar_carried?('The V-Cut Cigar Lounge', 'Tatuaje 7th Reserva').should be_true
  end

  it 'remembers cigars are not carried' do
    CigarStock.save_not_carried('Stag Tobacconist', 'Liga Privada Feral Flying Pig')
    CigarStock.cigar_carried?('Stag Tobacconist', 'Liga Privada Feral Flying Pig').should be_false
  end

  it "raises an exception if it can't find a cigar" do
    expect { CigarStock.cigar_carried?('Very Obscure Shop', 'Some Magic Cigar') }.to raise_exception(CigarStock::NoAnswer)
  end

  it 'creates a new record for new cigars' do
    expect { CigarStock.save_carried("Monte's", 'Tatuaje 7th Reserva') }.to change(CigarStock, :count).by(1)
  end

  it 'modifies existing records when given an already known cigar' do
    CigarStock.save_carried("Monte's", 'The Mummy')
    expect { CigarStock.save_not_carried("Monte's", 'The Mummy') }.not_to change(CigarStock, :count)
    CigarStock.cigar_carried?("Monte's", 'The Mummy').should be_false
  end
end
