class CigarFinderWeb.Views.CigarSearch extends Backbone.View
  template: JST['cigar_search']
  events:
    'submit #new-search': 'submitSearch'
  className: 'row'

  render: =>
    @loadLocation()
    @$el.html(@template())
    this

  submitSearch: (e) =>
    e.preventDefault()

  loadLocation: =>
    navigator.geolocation.getCurrentPosition (position) =>
      @position = position.coords
