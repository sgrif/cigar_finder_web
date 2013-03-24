require 'spec_helper'

describe CigarSearchLog do
  context '#log_search' do
    it 'saves a record of the search to the database' do
      ip = '127.0.0.1'
      cigar = 'Tatuaje 7th Reserva'
      expect do
        CigarSearchLog.log_search(ip, cigar)
      end.to change(CigarSearchLog, :count).by(1)
      CigarSearchLog.where(ip_address: ip, cigar: cigar).count.should == 1
    end

    it 'does not create duplicate records' do
      CigarSearchLog.log_search('127.0.0.1', 'Illusione CG4')
      expect do
        CigarSearchLog.log_search('127.0.0.1', 'Illusione CG4')
      end.not_to change(CigarSearchLog, :count)
    end

    it 'ignores case' do
      CigarSearchLog.log_search('67.41.101.230', 'la dueña')
      expect do
        CigarSearchLog.log_search('67.41.101.230', 'La Dueña')
      end.not_to change(CigarSearchLog, :count)
    end
  end
end
