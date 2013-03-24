class CigarFinderWeb.Routers.CigarSearchResults extends Backbone.Router
  routes:
    '': 'index'
    ':cigar_name': 'performSearch'

  index: ->
    view = new CigarFinderWeb.Views.Intro()
    @fadeTo(view.render().el)

  fadeTo: (html) ->
    $container = $('#container')
    $container.fadeOut =>
      $container.html(html)
      $container.fadeIn()

  performSearch: (cigar_name) ->
    @collection = new CigarFinderWeb.Collections.CigarSearchResults()
    @view = new CigarFinderWeb.Views.CigarSearch(collection: @collection)
    @fadeTo(@view.render().el)
    @view.performSearch(@decodeCigarName(cigar_name))
    window.the_view = @view

  decodeCigarName: (cigar_name) ->
    decodeURIComponent(cigar_name.replace(/[+]/g, "%20"))
