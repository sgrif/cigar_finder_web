describe "CigarFinderWeb.Views.MapMarkerView", =>
  [model, view, map, marker, cigarStore] = []

  beforeEach =>
    window.google =
      maps:
        Marker: ->
        Size: (x,y) -> [x, y]
        event:
          addListener: ->
    marker = jasmine.createSpyObj("marker", ["setMap", "setIcon"])
    spyOn(google.maps, "Marker").andReturn(marker)
    cigarStore = new Backbone.Model(name: "Jim's Cigars")
    cigarStore.getPosition = ->
    spyOn(cigarStore, 'getPosition').andReturn(lat: 1, lng: -1)
    model = new Backbone.Model(cigar_store: cigarStore)
    map = jasmine.createSpy("map")
    view = new CigarFinderWeb.Views.MapMarkerView(model: model)

  describe "cigar is carried by store", =>
    mockView = null

    beforeEach =>
      mockView = jasmine.createSpyObj('MapInfoWindowView', ['render'])
      spyOn(CigarFinderWeb.Views, 'MapInfoWindowView').andReturn(mockView)
      spyOn(google.maps.event, 'addListener')
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

    it "has an infowindow", =>
      expect(CigarFinderWeb.Views.MapInfoWindowView).toHaveBeenCalledWith
        model: model.get('cigar_store')

    it "opens its info window when clicked", =>
      expect(google.maps.event.addListener).toHaveBeenCalledWith(
        view.marker, 'click', view.openInfoWindow)
      view.openInfoWindow()
      expect(mockView.render).toHaveBeenCalledWith(marker)

  describe "cigar is not carried by store", =>
    beforeEach =>
      model.set("carried", false)
      view.render(map)

    it "renders the correct icon", =>
      expect(marker.setIcon).toHaveBeenCalledWith
        url: CigarFinderWeb.Views.MapMarkerIcons.ICON_NOT_CARRIED
        scaledSize: [6,6]

  describe "no information on cigar for store", =>
    beforeEach =>
      model.set("carried", null)
      view.render(map)

    it "renders the correct icon", =>
      expect(marker.setIcon).toHaveBeenCalledWith
        url: CigarFinderWeb.Views.MapMarkerIcons.ICON_NO_INFORMATION
        scaledSize: [6,6]

  describe "model changing", =>
    beforeEach =>
      view.render(map)

    it "updates its icon", =>
      model.set('carried', true)
      expect(marker.setIcon).toHaveBeenCalledWith(undefined)
