class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'
    ':cigar_name': 'performSearch'

  index: ->
    @collection = new CigarFinderWeb.Collections.CigarSearchResults()
    @view = new CigarFinderWeb.Views.CigarSearch(collection: @collection)
    $('#container').html(@view.render().el)

  performSearch: (cigar_name) ->
    @index() unless @view?
    @view.performSearch(@decodeCigarName(cigar_name))

  decodeCigarName: (cigar_name) ->
    decodeURIComponent(cigar_name.replace(/[+]/g, "%20"))
