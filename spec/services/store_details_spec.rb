require_relative '../../app/services/store_details'

describe StoreDetails do
  context '.load_needed' do
    before do
      StoreDetails.any_instance.stub(:load)
    end

    it 'loads the deatils for stores that need it' do
      loaded = double(id: 1, details_loaded?: true)
      not_loaded = double(id: 2, details_loaded?: false)
      StoreDetails.should_receive(:new).with(2).and_call_original
      StoreDetails.load_needed([loaded, not_loaded])
    end
  end
end
