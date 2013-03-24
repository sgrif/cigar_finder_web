require 'spec_helper'

describe 'main/index.html.erb' do
  it 'bootstraps given cigars for the javascript' do
    assign(:cigars, ['Tatuaje 7th Reserva', 'Illusione MK4'])
    render
    rendered.should include('<script>CigarFinderWeb.cigars = ["Tatuaje 7th Reserva","Illusione MK4"];</script>')
  end
end
