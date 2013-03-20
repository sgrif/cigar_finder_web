class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    @collection = new CigarFinderWeb.Collections.CigarSearchResults()
    @view = new CigarFinderWeb.Views.CigarSearch(collection: @collection)
    $('#container').html(@view.render().el)
