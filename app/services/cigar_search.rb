class CigarSearch
  def initialize(cigar, location)
    @cigar, @location = cigar, location
  end

  def results
    [CigarSearchResult.new("Monte's Cigars, Tobacco And Gifts", true)]
  end
end
