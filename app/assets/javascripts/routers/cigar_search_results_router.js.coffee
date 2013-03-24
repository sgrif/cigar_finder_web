class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'
    ':cigar_name': 'performSearch'

  index: ->
    @introView ||= new CigarFinderWeb.Views.Intro()
    @fadeTo(@introView)

  fadeTo: (view) ->
    unless @view is view
      @view = view
      $container = $('#container')
      $container.html(@view.render().el)

  performSearch: (cigar_name) ->
    unless @searchView?
      collection = new CigarFinderWeb.Collections.CigarSearchResults()
      @searchView = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    @fadeTo(@searchView)
    @searchView.performSearch(@decodeCigarName(cigar_name))
    window.the_view = @view

  decodeCigarName: (cigar_name) ->
    decodeURIComponent(cigar_name.replace(/[+]/g, "%20"))
