require 'spec_helper'

describe CigarsController do
  it 'returns a list of all cigars' do
    cigars = ['Tatuaje 7th Reserva', 'Illusione Mk', 'Padron 86']
    CigarSearchLog.stub(:all_cigars).and_return(cigars)
    get :index, format: :json
    response.code.should == '200'
    response.body.should == cigars.to_json
  end
end
