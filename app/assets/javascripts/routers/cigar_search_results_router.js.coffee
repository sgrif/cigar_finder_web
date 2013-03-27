class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'
    'add-a-cigar': 'addCigar'
    'add-a-cigar/:location': 'addCigar'
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
    @fadeTo(@introView, @introView.renderButtons)

  addCigar: (location) ->
    @introView ||= new CigarFinderWeb.Views.Intro(location: location)
    @fadeTo(@introView, @introView.renderAdd)

  performSearch: (cigar_name, location) ->
    location = decodePlus(location) if location?
    unless @searchView?
      collection = new CigarFinderWeb.Collections.CigarSearchResults()
      @searchView = new CigarFinderWeb.Views.CigarSearch(collection: collection)
    @fadeTo @searchView, =>
      @searchView.performSearch(decodePlus(cigar_name), location)
