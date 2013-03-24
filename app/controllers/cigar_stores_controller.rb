class CigarStoresController < ApplicationController
  def nearby
    @cigar_stores = CigarStoreSearch.new(params.fetch(:latitude), params.fetch(:longitude))
    render 'index'
  end
end
