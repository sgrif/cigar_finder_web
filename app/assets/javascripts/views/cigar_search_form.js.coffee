class CigarFinderWeb.Views.CigarSearchForm extends Backbone.View
  template: JST['cigar_search_form']

  events:
    'submit .cigar-search-form': 'performSearch'

  initialize: ->
    @on('search:loaded', @resetForm)

  render: =>
    @$el.html(@template())
    @$('.js-cigar-name').typeahead
      source: CigarFinderWeb.cigars
    this

  resetForm: =>
    @$('.cigar-search-form')[0].reset()
    @$(':submit').button('reset')

  performSearch: (e) =>
    e.preventDefault()
    cigar_name = @$('.js-cigar-name').val()
    if cigar_name
      @$(':submit').button('loading')
      Backbone.history.navigate(encodePlus(cigar_name), trigger: true)
