class CigarFinderWeb.Views.MapView extends Backbone.View
  id: 'map-canvas'

  initialize: ->
    @collection.on('reset', @renderMap)

  renderMap: =>
    @collection.loadLocation =>
      @map ||= new google.maps.Map @el,
        center: @getLatLng()
        zoom: 11
        mapTypeId: google.maps.MapTypeId.ROADMAP

  getLatLng: =>
    lat = @collection.position.latitude
    lon = @collection.position.longitude
    new google.maps.LatLng(lat, lon)
