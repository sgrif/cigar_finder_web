require 'spec_helper'

describe CigarStoresController do
  context '#nearby' do
    it 'returns stores near a location' do
      store = CigarStore.create!(name: "Monte's")
      CigarStoreSearch.any_instance.should_receive(:results).and_return([store])

      get :nearby, latitude: 1, longitude: -1, format: :json
      response.code.should == '200'
      response.body.should == [store].to_json
    end
  end

  context '#missing_information' do
    it 'returns the most popular cigar with no information for a store' do
      CigarStore.stub(:find).and_return(mock_model(CigarStore))
      UnknownStocks.any_instance.stub(:most_popular).and_return('Tatuaje 7th Reserva')

      get :missing_information, id: 1, format: :json
      response.code.should == '200'
      ActiveSupport::JSON.decode(response.body).should == { 'cigar' => 'Tatuaje 7th Reserva' }
    end
  end
end
