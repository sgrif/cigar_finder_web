class ConfirmedCigar < ActiveRecord::Base
  def self.confirm(cigar)
    where(name: cigar).first_or_create!
  end
end
