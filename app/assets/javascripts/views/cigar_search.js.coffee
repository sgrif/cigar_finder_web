class CigarFinderWeb.Views.CigarSearch extends Backbone.View
  template: JST['cigar_search']
  events:
    'submit #new-search': 'submitSearch'

  initialize: =>
    @collection.on('reset', @searchLoaded)
    @resultsView = new CigarFinderWeb.Views.CigarSearchResultsIndex(collection: @collection)
    @mapView = new CigarFinderWeb.Views.MapView(collection: @collection)

  render: =>
    @$el.html(@template()) unless @$el.text()
    @delegateEvents()
    @$('#new-search-cigar').typeahead(source: CigarFinderWeb.cigars)
    @$('#js-cigar-search-results').html(@resultsView.render().el)
    @$('#js-cigar-map').html(@mapView.render().el)
    this

  encodeCigarName: (cigar_name) =>
    encodePlus(cigar_name)

  submitSearch: (e) =>
    e.preventDefault()
    cigar_name = @$('#new-search-cigar').val()
    if cigar_name
      @performSearch(cigar_name)
      Backbone.history.navigate(@encodeCigarName(cigar_name), trigger: false)

  performSearch: (cigar) =>
    @cigar = cigar
    CigarFinderWeb.cigars.push(cigar) unless _.contains(CigarFinderWeb.cigars, cigar)
    @collection.fetchCigar(cigar)

  searchLoaded: =>
    @$('#js-cigar-name').html(@cigar)
    if @$('#new-search').length
      @$('#new-search')[0].reset()
