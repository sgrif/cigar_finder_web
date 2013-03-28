require 'spec_helper'

describe CigarSearchResultsController do
  let(:cigar_store_attributes) { { name: "Jim's Cigars", latitude: 3, longitude: 4 } }
  let(:cigar_store) { stub_model(CigarStore, cigar_store_attributes) }

  before do
    CigarStoreSearch.stub(:new)
    CigarSearchLog.stub(:log_search)
    CigarSearch.any_instance.stub(:results)
  end

  it 'shows nearby stocks for cigars' do
    CigarSearch.any_instance.stub(:results) { [{store: cigar_store, carried: true}] }
    get :index, longitude: 1, latitude: 2, cigar: 'Tatuaje 7th Reserva', format: :json
    response.should render_template('index')
    response.code.should == '200'
  end

  it 'logs that the search was performed' do
    CigarSearchLog.should_receive(:log_search).with('0.0.0.0', 'La Dueña')
    get :index, cigar: 'La Dueña', latitude: 1, longitude: -1, format: :json
  end
end
