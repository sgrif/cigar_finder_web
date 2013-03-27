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

  onSearchLoaded: (cigar) =>
    @cigar = cigar
    @resetForm()

  resetForm: =>
    @el.reset()
    @$(':submit').button('reset')

  performSearch: (e) =>
    e.preventDefault()
    cigar_name = @$('.js-cigar-name').val()
    if cigar_name and cigar_name.toLowerCase() isnt @cigar.toLowerCase()
      @$(':submit').button('loading')
      Backbone.history.navigate(encodePlus(cigar_name), trigger: true)
    else
      @resetForm()
