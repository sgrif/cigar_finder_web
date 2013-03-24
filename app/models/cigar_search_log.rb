class CigarSearchLog < ActiveRecord::Base
  def self.log_search(ip_address, cigar)
    where(ip_address: ip_address, cigar: cigar.titleize).first_or_create!
  end
end
