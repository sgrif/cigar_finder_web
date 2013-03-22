class CigarFinderWeb.Views.MapMarkerView extends Backbone.View
  render: (map) =>
    @renderMarker(map) if @model.get('carried')

  renderMarker: (map) =>
    @marker ||= new google.maps.Marker
      position: @getLatLng()
      map: map
      title: @model.get('cigar_store').name
    @infoWindow ||= new CigarFinderWeb.Views.MapInfoWindowView(model: @model.get('cigar_store'))
    google.maps.events.addListener(@marker, 'click', @openInfoWindow)

  remove: =>
    @removeMarker()
    super()

  removeMarker: =>
    @marker.setMap(null) if @marker?

  openInfoWindow: =>
    @infoWindow.render(@marker)

  getLatLng: =>
    lat = @model.get('cigar_store').latitude
    lon = @model.get('cigar_store').longitude
    new google.maps.LatLng(lat, lon)
