class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'
    ':cigar_name': 'performSearch'
    ':cigar_name/:location': 'performSearch'

  index: ->
    collection = new CigarFinderWeb.Collections.CigarSearchResults()
    @searchView = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    $('#container').html(@searchView.render().el)

  performSearch: (cigar_name, location) ->
    cigar_name = toTitleCase(decodePlus(cigar_name))
    location = decodePlus(location) if location?
    @index() unless @searchView?
    @searchView.performSearch(cigar_name, location)
