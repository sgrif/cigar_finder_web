require 'spec_helper'

describe MainController do
  describe '#index' do
    it 'loads all known cigars' do
      CigarSearchLog.should_receive(:all_cigars)
      get :index
    end
  end
end
