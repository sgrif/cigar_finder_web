class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    @view = new CigarFinderWeb.Views.CigarSearch()
    $('#container').html(@view.render().el)
