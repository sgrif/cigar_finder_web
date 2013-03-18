class CigarFinderWeb.Views.CigarSearchResult extends Backbone.View
  template: JST['cigar_search_results/result']

  initialize: ->
    @map = @options.map

  render: ->
    $(@el).html(@template(result: @model))
    @renderMarker()
    this

  renderMarker: ->
    @marker = new google.maps.Marker
      position: @getPosition()
      map: @map
      title: @model.get('cigar_store').name

  getPosition: ->
    new google.maps.LatLng(@model.get('cigar_store').latitude, @model.get('cigar_store').longitude)
