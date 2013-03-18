class CigarFinderWeb.Views.CigarSearchResultsIndex extends Backbone.View
  template: JST['cigar_search_results/index']
  events:
    'submit #new_search': 'submitSearch'
  className: 'row'

  initialize: ->
    @collection.on('reset', @render, this)

  render: =>
    $(@el).html(@template(cigar: @cigar))
    @loadMap()
    @collection.each(@addResult)
    this

  addResult: (result) =>
    view = new CigarFinderWeb.Views.CigarSearchResult(model: result, map: @map)
    @$('#search-results').append(view.render().el)

  submitSearch: (e) ->
    e.preventDefault()
    Backbone.history.navigate(encodeURIComponent($('#new_search_cigar').val()), trigger: true)

  performSearch: (cigar) ->
    @loadLocation (position) =>
      @cigar = cigar
      lat = position.coords.latitude
      lon = position.coords.longitude
      @collection.fetch(data: {cigar: @cigar, latitude: lat, longitude: lon})

  loadLocation: (callback) ->
    return callback(@position) if @position?
    navigator.geolocation.getCurrentPosition (position) =>
      @position = position
      callback(@position)

  loadMap: =>
    @loadLocation (position) =>
      center = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
      @map = new google.maps.Map @$('#map-canvas')[0],
        center: center
        zoom: 10
        mapTypeId: google.maps.MapTypeId.ROADMAP
