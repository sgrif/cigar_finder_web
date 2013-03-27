class CigarFinderWeb.Views.MapView extends Backbone.View
  id: 'map-canvas'
  markerViews: []

  initialize: (options) ->
    @location = options.location
    @collection.on('reset', @renderMap)

  renderMap: =>
    CigarFinderWeb.Services.LocationLoader.loadLocation @collection.location, (position) =>
      center = new google.maps.LatLng(position.latitude, position.longitude)
      if @map
        @map.setCenter(center)
      else
        @map = new google.maps.Map @el,
          center: center
          zoom: 11
          mapTypeId: google.maps.MapTypeId.ROADMAP
      @renderMarkers()

  renderMarkers: =>
    marker.remove() for marker in @markerViews
    @markerViews = []
    @collection.forEach (model) =>
      @marker = new CigarFinderWeb.Views.MapMarkerView(model: model)
      @markerViews.push(@marker)
      @marker.render(@map)
