describe 'CigarFinderWeb.Models.CigarStore', ->
  beforeEach ->
    window.google =
      maps:
        LatLng: ->
    spyOn(google.maps, 'LatLng')

  it 'gets its position', ->
    model = new CigarFinderWeb.Models.CigarStore(latitude: 1, longitude: -1)
    model.getPosition()
    expect(google.maps.LatLng).toHaveBeenCalledWith(1, -1)

  it 'gives a link for directions', ->
    model = new CigarFinderWeb.Models.CigarStore
      name: "Jim's Cigars"
      address: "100 Main Street Pleasantville"
    expect(model.directionsLink()).toBe(
      "https://maps.google.com/maps?daddr=Jim's+Cigars%2C+100+Main+Street+Pleasantville")
