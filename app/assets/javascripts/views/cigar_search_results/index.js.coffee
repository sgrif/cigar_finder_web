class CigarFinderWeb.Views.CigarSearchResultsIndex extends Backbone.View
  template: JST['cigar_search_results/index']
  events:
    'submit #new_search': 'submitSearch'
  className: 'row'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(results: @collection, cigar: @cigar))
    this

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
    callback(@position) if @position?
    navigator.geolocation.getCurrentPosition (position) =>
      @position = position
      callback(@position)
