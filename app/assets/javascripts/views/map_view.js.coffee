class CigarFinderWeb.Views.MapView extends Backbone.View
  id: 'map-canvas'
  markerViews: []

  initialize: ->
    @collection.on('reset', @renderMap)

  renderMap: =>
    CigarFinderWeb.Services.LocationLoader.loadLocation (position) =>
      @map ||= new google.maps.Map @el,
        center: new google.maps.LatLng(position.latitude, position.longitude)
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
