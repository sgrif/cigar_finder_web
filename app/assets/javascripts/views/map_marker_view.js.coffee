class CigarFinderWeb.Views.MapMarkerView extends Backbone.View
  render: (map) =>
    if @model.get('carried')
      @marker = new google.maps.Marker
        position: @getLatLng()
        map: map
        title: @model.get('cigar_store').name

  remove: =>
    @marker.setMap(null) if @marker?
    super()

  getLatLng: =>
    lat = @model.get('cigar_store').latitude
    lon = @model.get('cigar_store').longitude
    new google.maps.LatLng(lat, lon)
