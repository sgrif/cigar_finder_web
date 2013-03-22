class CigarFinderWeb.Views.MapView extends Backbone.View
  id: 'map-canvas'
  markerViews: []

  initialize: ->
    @collection.on('reset', @renderMap)

  renderMap: =>
    @collection.loadLocation =>
      @map ||= new google.maps.Map @el,
        center: @getLatLng()
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

  getLatLng: =>
    lat = @collection.position.latitude
    lon = @collection.position.longitude
    new google.maps.LatLng(lat, lon)
