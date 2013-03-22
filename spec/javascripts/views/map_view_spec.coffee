describe "CigarFinderWeb.Views.MapView", ->
  [collection, view, $el] = []

  beforeEach =>
    window.google =
      maps:
        Map: ->
        LatLng: ->
        MapTypeId:
          ROADMAP: 1
    collection = new Backbone.Collection()
    collection.position = {latitude: 1, longitude: -1}
    collection.loadLocation = (success) ->
      success()
    view = new CigarFinderWeb.Views.MapView(collection: collection)
    $el = $(view.render().el)

  describe 'collection resetting', =>
    beforeEach =>
      spyOn(google.maps, "Map")
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
