require 'spec_helper'

describe CigarStoresController do
  it 'searches for stores near the given location' do
    cigar_store_search = double('cigar store search')
    CigarStoreSearch.stub(:new) { cigar_store_search }
    CigarStoreSearch.should_receive(:new).with(1.23, -3.21)
    get :nearby, latitude: 1.23, longitude: -3.21, format: :json
    response.should render_template('index')
    response.code.should == '200'
    assigns(:cigar_stores).should == cigar_store_search
  end
end
