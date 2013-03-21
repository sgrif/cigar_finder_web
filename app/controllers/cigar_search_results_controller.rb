class CigarSearchResultsController < ApplicationController
  def index
    latitude = params[:latitude] || request.location.latitude
    longitude = params[:longitude] || request.location.longitude
    stores = CigarStoreSearch.new(latitude, longitude)
    @search_results = CigarSearch.new(params.fetch(:cigar), stores).results
  end
end
