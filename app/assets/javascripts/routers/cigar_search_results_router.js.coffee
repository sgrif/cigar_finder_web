class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'
    ':cigar_name': 'performSearch'

  index: ->
    @searchView.remove() if @searchView?
    @introView = new CigarFinderWeb.Views.Intro()
    @fadeTo(@introView)

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

  performSearch: (cigar_name) ->
    unless @searchView?
      collection = new CigarFinderWeb.Collections.CigarSearchResults()
      @searchView = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    @fadeTo @searchView, =>
      @searchView.performSearch(@decodeCigarName(cigar_name))

  decodeCigarName: (cigar_name) ->
    decodeURIComponent(cigar_name.replace(/[+]/g, "%20"))
