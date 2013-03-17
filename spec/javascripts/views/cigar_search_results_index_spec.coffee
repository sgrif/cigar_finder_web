describe 'CigarFinderWeb.Views.CigarSearchResultsIndex', ->
  beforeEach =>
    $('body').append($('<div id="container">'))
    @collection = new Backbone.Collection()
    @resultsView = new CigarFinderWeb.Views.CigarSearchResultsIndex(collection: @collection)
    $('#container').append(@resultsView.render().el)

  afterEach =>
    @resultsView.remove()
    $('#container').remove()

  describe 'searching for a cigar', =>
    beforeEach =>
      spyOn(navigator.geolocation, 'getCurrentPosition').andCallFake (callback) ->
        callback(coords: {latitude: 1, longitude: -1})
      spyOn(@collection, 'fetch')

    performSearch = =>
      @resultsView.$('#new_search_cigar').val('Tatuaje 7th Reserva')
      @resultsView.$('#new_search').trigger('submit')

    it 'calls the search api', =>
      performSearch()
      expect(@collection.fetch).toHaveBeenCalledWith(data: {cigar: 'Tatuaje 7th Reserva', latitude: 1, longitude: -1})

    it 'rerenders itself', =>
      spyOn(@resultsView, 'render')
      performSearch()
      expect(@resultsView.render).toHaveBeenCalled
