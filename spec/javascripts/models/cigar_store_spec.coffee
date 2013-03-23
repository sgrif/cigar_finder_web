describe 'CigarFinderWeb.Models.CigarStore', ->
  beforeEach ->
    window.google =
      maps:
        LatLng: ->
    spyOn(google.maps, 'LatLng')

  it 'gets its position', ->
    view = new CigarFinderWeb.Models.CigarStore(latitude: 1, longitude: -1)
    view.getPosition()
    expect(google.maps.LatLng).toHaveBeenCalledWith(1, -1)
