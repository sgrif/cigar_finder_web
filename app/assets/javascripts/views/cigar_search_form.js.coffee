class CigarFinderWeb.Views.CigarSearchForm extends Backbone.View
  template: JST['cigar_search_form']
  cigar: ''

  events:
    'submit': 'performSearch'

  initialize: ->
    @on('search:loaded', @onSearchLoaded)

  render: =>
    @$el.addClass('cigar-search-form')
    @$el.html(@template())
    @$('.js-cigar-name').typeahead
      source: CigarFinderWeb.cigars
    this

  onSearchLoaded: (cigar, location) =>
    @cigar = cigar
    @location = location || ''
    @resetForm()

  resetForm: =>
    @el.reset()
    @$(':submit').button('reset')

  performSearch: (e) =>
    e.preventDefault()
    if @$('.js-cigar-name').val() and @queryDiffers()
      @$(':submit').button('loading')
      @navigateToSearchResults()
    else
      @resetForm()

  queryDiffers: =>
    @$('.js-cigar-name').val() != @cigar || @$('.js-search-location').val() != @location

  navigateToSearchResults: =>
    search_results_url = encodePlus(@$('.js-cigar-name').val())
    location = @$('.js-search-location').val()
    if location
      search_results_url += "/#{encodePlus(location)}"
    Backbone.history.navigate(search_results_url, trigger: true)
