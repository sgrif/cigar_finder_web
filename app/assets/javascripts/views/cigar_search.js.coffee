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
    cigar_input = @$('#new-search-cigar')
    @performSearch(cigar_input.val())
    $(e.currentTarget)[0].reset()

  performSearch: (cigar) =>
    @$('#js-cigar-name').html(cigar)
    @collection.fetch
      data:
        cigar: cigar
        latitude: @position.latitude
        longitude: @position.longitude

  loadLocation: (callback = ->) =>
    callback() if @position?
    navigator.geolocation.getCurrentPosition (position) =>
      @position = position.coords
      callback()
