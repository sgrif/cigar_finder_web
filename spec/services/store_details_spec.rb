require 'spec_helper'

describe StoreDetails do
  let(:montes) { CigarStore.create!(name: "Monte's", google_details_reference: 'montes') }
  let(:stag) { CigarStore.create!(name: 'Stag') }

  context '.load_needed' do
    it 'loads the deatils for stores that need it' do
      montes.stub(:details_loaded?).and_return(false)
      stag.stub(:details_loaded?).and_return(true)
      OnlinePlaceDetails.should_receive(:for).with('montes').and_return(phone_number: '505-850-9255')
      StoreDetails.load_needed([montes, stag])
      montes.reload.phone_number.should == '505-850-9255'
    end
  end
end
