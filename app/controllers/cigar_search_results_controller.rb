class CigarSearchResultsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:report_carried, :report_not_carried]
  respond_to :json

  def index
    stores = CigarStoreSearch.new(params.fetch(:latitude), params.fetch(:longitude))
    cigar_search = CigarSearch.new(params.fetch(:cigar), stores)
    cigar_search.log_search(request.remote_ip)
    @search_results = cigar_search.results
  end

  def report_carried
    render json: CigarStock.save_carried(params.fetch(:cigar_store_id),
                                         params.fetch(:cigar))
  end

  def report_not_carried
    render json: CigarStock.save_not_carried(params.fetch(:cigar_store_id),
                                             params.fetch(:cigar))
  end
end
