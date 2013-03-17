class CigarFinderWeb.Views.CigarSearchResultsIndex extends Backbone.View
  template: JST['cigar_search_results/index']
  events:
    'submit #new_search': 'performSearch'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(results: @collection, cigar: @cigar))
    this

  performSearch: (e) ->
    e.preventDefault()
    @loadLocation (position) =>
      @cigar = $('#new_search_cigar').val()
      lat = position.coords.latitude
      lon = position.coords.longitude
      @collection.fetch(data: {cigar: @cigar, latitude: lat, longitude: lon})

  loadLocation: (callback) ->
    callback(@position) if @position?
    navigator.geolocation.getCurrentPosition (position) =>
      @position = position
      callback(@position)
