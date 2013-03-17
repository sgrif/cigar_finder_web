describe 'CigarFinderWeb.Views.CigarSearchResultsIndex', ->
  beforeEach ->
    $('body').append($('<div id="container">'))
    @collection = new Backbone.Collection()
    @resultsView = new CigarFinderWeb.Views.CigarSearchResultsIndex(collection: @collection)
    $('#container').append(@resultsView.render().el)

  afterEach ->
    @resultsView.remove()
    $('#container').remove()

  it 'searches for a cigar', ->
    spyOn(navigator.geolocation, 'getCurrentPosition').andCallFake (callback) ->
      callback(coords: {latitude: 1, longitude: -1})
    spyOn(@collection, 'fetch')
    @resultsView.$('#new_search_cigar').val('Tatuaje 7th Reserva')
    @resultsView.$('#new_search').trigger('submit')

    expect(@collection.fetch).toHaveBeenCalledWith(data: {cigar: 'Tatuaje 7th Reserva', latitude: 1, longitude: -1})
