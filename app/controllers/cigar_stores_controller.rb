class CigarStoresController < ApplicationController
  def missing_information
    cigar_store = CigarStore.find(params[:id])
    unknown_inventory = UnknownStocks.new(cigar_store)
    render json: { cigar: unknown_inventory.most_popular }
  end
end
