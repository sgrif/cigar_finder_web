class CigarSearchesController < ApplicationController
  def show
    stores = CigarStoreSearch.new(params.fetch(:latitude), params.fetch(:longitude))
    @cigar = params.fetch(:cigar)
    @search_results = CigarSearch.new(@cigar, stores).results
  end
end
