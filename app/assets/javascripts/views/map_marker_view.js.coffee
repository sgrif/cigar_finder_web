class CigarFinderWeb.Views.MapMarkerView extends Backbone.View
  render: (map) =>
    @renderMarker(map) if @model.get('carried')

  renderMarker: (map) =>
    @marker ||= new google.maps.Marker
      position: @model.get('cigar_store').getPosition()
      map: map
      title: @model.get('cigar_store').get('name')
    @infoWindow ||= new CigarFinderWeb.Views.MapInfoWindowView(model: @model.get('cigar_store'))
    google.maps.event.addListener(@marker, 'click', @openInfoWindow)

  remove: =>
    @removeMarker()
    super()

  removeMarker: =>
    @marker.setMap(null) if @marker?

  openInfoWindow: =>
    @infoWindow.render(@marker)
