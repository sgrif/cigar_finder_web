class CigarFinderWeb.Views.CigarSearch extends Backbone.View
  template: JST['cigar_search']
  events:
    'submit #new-search': 'submitSearch'
  className: 'row'

  initialize: =>
    @collection.on('reset', @searchLoaded)

  render: =>
    @loadLocation()
    @$el.html(@template())
    resultsView = new CigarFinderWeb.Views.CigarSearchResultsIndex(collection: @collection)
    @$('#js-cigar-search-results').append(resultsView.render().el)
    this

  encodeCigarName: (cigar_name) =>
    encodeURIComponent(cigar_name).replace(/(%20)+/g, "+")

  submitSearch: (e) =>
    e.preventDefault()
    cigar_name = @$('#new-search-cigar').val()
    @performSearch(cigar_name)
    Backbone.history.navigate(@encodeCigarName(cigar_name), trigger: false)

  performSearch: (cigar) =>
    @loadLocation =>
      @cigar = cigar
      @collection.fetch
        data:
          cigar: cigar
          latitude: @position.latitude
          longitude: @position.longitude

  searchLoaded: =>
    @$('#js-cigar-name').html(@cigar)
    @$('#new-search')[0].reset()

  loadLocation: (callback = ->) =>
    callback() if @position?
    navigator.geolocation.getCurrentPosition (position) =>
      @position = position.coords
      callback()
