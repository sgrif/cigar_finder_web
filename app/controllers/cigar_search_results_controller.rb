class CigarSearchResultsController < ApplicationController
  def index
    stores = CigarStoreSearch.new(params.fetch(:latitude), params.fetch(:longitude))
    @search_results = CigarSearch.new(params.fetch(:cigar), stores).results
  end
end
