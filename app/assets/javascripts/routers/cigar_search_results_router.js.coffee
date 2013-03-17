class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'
    ':cigar': 'search'

  index: ->
    @collection = new CigarFinderWeb.Collections.CigarSearchResults()
    @view = new CigarFinderWeb.Views.CigarSearchResultsIndex(collection: @collection)
    $('#container').html(@view.render().el)

  search: (cigar) ->
    @index() unless @view?
    @view.performSearch(decodeURIComponent(cigar))
