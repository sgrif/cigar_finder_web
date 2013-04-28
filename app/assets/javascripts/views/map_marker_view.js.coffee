class CigarFinderWeb.Views.MapMarkerView extends Backbone.View
  initialize: =>
    @model.on('change', @updateIcon)

  render: (map) =>
    @renderMarker(map)

  renderMarker: (map) =>
    @marker ||= new google.maps.Marker
      position: @model.get('cigar_store').getPosition()
      map: map
      title: @model.get('cigar_store').get('name')
    @infoWindow ||= new CigarFinderWeb.Views.MapInfoWindowView(model: @model.get('cigar_store'))
    google.maps.event.addListener(@marker, 'click', @openInfoWindow)
    @updateIcon()

  updateIcon: =>
    @marker.setIcon(@getIcon()) if @marker?

  remove: =>
    @removeMarker()
    super()

  removeMarker: =>
    @marker.setMap(null) if @marker?

  openInfoWindow: =>
    @infoWindow.render(@marker)

  getIcon: =>
    switch @model.get('carried')
      when true
        url: CigarFinderWeb.Views.MapMarkerIcons.ICON_CARRIED
        scaledSize: new google.maps.Size(32, 32)
      when false
        url: CigarFinderWeb.Views.MapMarkerIcons.ICON_NOT_CARRIED
        scaledSize: new google.maps.Size(6,6)
      else
        url: CigarFinderWeb.Views.MapMarkerIcons.ICON_NO_INFORMATION
        scaledSize: new google.maps.Size(6,6)
