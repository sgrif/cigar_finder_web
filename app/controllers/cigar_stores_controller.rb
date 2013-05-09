class CigarStoresController < ApplicationController
  def nearby
    latitude = params.fetch(:latitude)
    longitude = params.fetch(:longitude)
    @cigar_stores = CigarStoreSearch.new(latitude, longitude).to_a
    render 'index'
  end

  def missing_information
    cigar_store = CigarStore.find(params[:id])
    unknown_inventory = UnknownStocks.new(cigar_store)
    render json: { cigar: unknown_inventory.most_popular }
  end
end
