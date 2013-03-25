require 'spec_helper'

describe 'cigar_stores/index' do
  let(:montes) { { 'name' => "Monte's", 'latitude' => 1.23, 'longitude' => -1.23,
    'address' => '3636 San Mateo', 'id' => 1 } }
  let(:stag) { { 'name' => 'Stag', 'latitude' => 2.31, 'longitude' => -2.13,
    'address' => 'Middle of Nowhere', 'id' => 2 } }

  it 'renders a list of cigar stores' do
    assign(:cigar_stores, [CigarStore.create!(montes), CigarStore.create!(stag)])
    render
    ActiveSupport::JSON.decode(rendered).should == [montes, stag]
  end
end
