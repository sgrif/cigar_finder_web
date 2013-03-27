class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'
    ':cigar_name': 'performSearch'
    ':cigar_name/:location': 'performSearch'

  fadeTo: (view, callback = (->)) ->
    if @view is view
      callback()
    else
      @view = view
      $container = $('#container')
      $container.fadeOut =>
        $container.html(@view.render().el)
        $container.fadeIn()
        callback()

  index: ->
    @searchView.remove() if @searchView?
    @introView = new CigarFinderWeb.Views.Intro()
    @fadeTo(@introView)

  performSearch: (cigar_name, location) ->
    location = decodePlus(location) if location?
    unless @searchView?
      collection = new CigarFinderWeb.Collections.CigarSearchResults()
      @searchView = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    @fadeTo @searchView, =>
      @searchView.performSearch(decodePlus(cigar_name), location)
