require 'spec_helper'

describe CigarStoresController do
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
