class CigarFinderWeb.Views.MapInfoWindowView extends Backbone.View
  [openInfoWindow] = []

  template: JST['cigar_search_results/infowindow']

  removeOpenInfoWindow = ->
    openInfoWindow.remove() if openInfoWindow?
    openInfoWindow = null

  setOpenInfoWindow = (view) ->
    openInfoWindow = view

  render: (marker) =>
    removeOpenInfoWindow()
    setOpenInfoWindow(this)
    @infoWindow = new google.maps.InfoWindow(content: @template(cigar_store: @model))
    @infoWindow.open(marker.getMap(), marker)

  remove: =>
    @infoWindow.close() if @infoWindow?
    @infoWindow = null
    super()
