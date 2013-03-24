class CigarSearchResultsController < ApplicationController
  def index
    latitude = params[:latitude] || request.location.latitude
    longitude = params[:longitude] || request.location.longitude
    stores = CigarStoreSearch.new(latitude, longitude)
    cigar_search = CigarSearch.new(params.fetch(:cigar), stores)
    cigar_search.log_search(request.remote_ip)
    @search_results = cigar_search.results
  end
end
