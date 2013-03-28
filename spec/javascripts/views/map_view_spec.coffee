describe "CigarFinderWeb.Views.MapView", ->
  [collection, view, $el] = []

  beforeEach =>
    window.google =
      maps:
        Map: ->
          setCenter: ->
        LatLng: ->
        MapTypeId:
          ROADMAP: 1
        event:
          addListener: ->
    spyOn(google.maps.event, 'addListener')
    spyOn(CigarFinderWeb.Services.LocationLoader, 'loadLocation').andCallFake (l, callback) =>
      if l?
        callback(latitude: 2, longitude: -2)
      else
        callback(latitude: 1, longitude: -1)
    collection = new Backbone.Collection()
    view = new CigarFinderWeb.Views.MapView(collection: collection)
    $el = $(view.render().el)

  describe 'on click', =>
    it "closes any open infowindows", =>
      view.renderMap()
      expect(google.maps.event.addListener).toHaveBeenCalledWith(view.map, 'click',
        CigarFinderWeb.Views.MapInfoWindowView.removeOpenInfoWindow)

  describe 'collection resetting', =>
    beforeEach =>
      spyOn(google.maps, "Map").andCallThrough()
      spyOn(google.maps, "LatLng").andCallFake (lat, lng) ->
        {lat: lat, lng: lng}
      collection.reset()

    it "renders a google map", =>
      expect(google.maps.Map).toHaveBeenCalledWith $el[0],
        center: { lat: 1, lng: -1 }
        zoom: 11
        mapTypeId: google.maps.MapTypeId.ROADMAP

    it "only renders the map once", =>
      collection.reset()
      expect(google.maps.Map.callCount).toBe(1)

    it "recenters the map", =>
      view.renderMap()
      spyOn(view.map, 'setCenter')
      collection.location = "Albuquerque"
      collection.reset()
      expect(CigarFinderWeb.Services.LocationLoader.loadLocation).toHaveBeenCalledWith(
        'Albuquerque', jasmine.any(Function))
      expect(view.map.setCenter).toHaveBeenCalledWith(lat: 2, lng: -2)

    describe "marker views", =>
      mockMarker = null

      beforeEach =>
        mockMarker = new Backbone.View()
        spyOn(mockMarker, "render")
        spyOn(mockMarker, "remove")
        spyOn(CigarFinderWeb.Views, "MapMarkerView").andReturn(mockMarker)

      it "creates marker views", =>
        [firstModel, secondModel] = [new Backbone.Model(), new Backbone.Model()]
        collection.reset([firstModel, secondModel])
        expect(CigarFinderWeb.Views.MapMarkerView).toHaveBeenCalledWith(model: firstModel)
        expect(mockMarker.render).toHaveBeenCalledWith(view.map)
        expect(CigarFinderWeb.Views.MapMarkerView).toHaveBeenCalledWith(model: secondModel)

      it "removes existing marker views", =>
        collection.reset([new Backbone.Model()])
        collection.reset()
        expect(mockMarker.remove).toHaveBeenCalled()
