require 'spec_helper'

describe CigarSearchResultsController do
  let(:cigar_store_attributes) { { name: "Jim's Cigars", latitude: 3, longitude: 4 } }
  let(:cigar_store) { CigarStore.create!(cigar_store_attributes) }
  let(:cigar_stock) { double('cigar_stock', to_json: 'CigarStock double') }

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

  it 'reports that a cigar is carried by a store' do
    CigarStock.should_receive(:save_carried).with(cigar_store.id, 'Illusione Mk')
      .and_return(cigar_stock)
    post :report_carried, cigar_store_id: cigar_store.id, cigar: 'Illusione Mk', format: :json
    response.body.should == 'CigarStock double'
    response.code.should == '200'
  end

  it 'reports that a cigar is not carried by a store' do
    CigarStock.should_receive(:save_not_carried).with(cigar_store.id, 'El Mundo Del Rey')
      .and_return(cigar_stock)
    post :report_not_carried, cigar_store_id: cigar_store.id, cigar: 'El Mundo Del Rey',
      format: :json
    response.body.should == 'CigarStock double'
    response.code.should == '200'
  end
end
