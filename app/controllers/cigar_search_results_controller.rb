class CigarSearchResultsController < ApplicationController
  respond_to :json

  def index
    latitude = params[:latitude] || request.location.latitude
    longitude = params[:longitude] || request.location.longitude
    stores = CigarStoreSearch.new(latitude, longitude)
    cigar_search = CigarSearch.new(params.fetch(:cigar), stores)
    cigar_search.log_search(request.remote_ip)
    @search_results = cigar_search.results
  end

  def create
    if params.fetch(:carried).present?
      CigarStock.save_carried(params.fetch(:cigar_store_id), params.fetch(:cigar))
    else
      CigarStock.save_not_carried(params.fetch(:cigar_store_id), params.fetch(:cigar))
    end
    render nothing: true
  end
end
