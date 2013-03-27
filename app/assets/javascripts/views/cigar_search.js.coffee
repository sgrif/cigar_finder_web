class CigarFinderWeb.Views.CigarSearch extends Backbone.View
  template: JST['cigar_search']

  initialize: =>
    @collection.on('reset', @searchLoaded)
    @resultsView = new CigarFinderWeb.Views.CigarSearchResultsIndex(collection: @collection)
    @mapView = new CigarFinderWeb.Views.MapView(collection: @collection)
    @formView = new CigarFinderWeb.Views.CigarSearchForm()

  render: =>
    @$el.html(@template()) unless @$el.text()
    @delegateEvents()
    @$('#js-cigar-search-results').html(@resultsView.render().el)
    @$('#js-cigar-map').html(@mapView.render().el)
    @assign(@formView, '#js-new-search')
    this

  performSearch: (cigar) =>
    @cigar = cigar
    CigarFinderWeb.cigars.push(cigar) unless _.contains(CigarFinderWeb.cigars, cigar)
    @collection.fetchCigar(cigar)

  searchLoaded: =>
    @$('#js-cigar-name').html(@cigar)
    @formView.trigger('search:loaded', @cigar)
