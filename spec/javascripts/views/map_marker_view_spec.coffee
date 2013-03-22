describe "CigarFinderWeb.Views.MapMarkerView", =>
  [model, view, map, marker] = []

  beforeEach =>
    window.google =
      maps:
        LatLng: ->
        Marker: ->
    spyOn(google.maps, "LatLng").andCallFake (lat, lng) ->
      {lat: lat, lng: lng}
    marker = jasmine.createSpyObj("marker", ["setMap"])
    spyOn(google.maps, "Marker").andReturn(marker)
    model = new Backbone.Model(cigar_store: {name: "Jim's Cigars", latitude: 1, longitude: -1})
    map = jasmine.createSpy("map")
    view = new CigarFinderWeb.Views.MapMarkerView(model: model)

  describe "cigar is carried by store", =>
    beforeEach =>
      model.set("carried", true)
      view.render(map)

    describe "remove", =>
      it "destroys its marker", =>
        view.remove()
        expect(marker.setMap).toHaveBeenCalledWith(null)

    it "renders a marker on the map", =>
      expect(google.maps.Marker).toHaveBeenCalledWith
        position: {lat: 1, lng: -1}
        map: map
        title: "Jim's Cigars"

  describe "cigar is not carried by store", =>
    beforeEach =>
      model.set("carried", false)
      view.render(map)

    it "does not render a marker on the map", =>
      expect(google.maps.Marker).not.toHaveBeenCalled()

    it "does nothing when remove is called", =>
      view.remove()
      expect(marker.setMap).not.toHaveBeenCalled()
