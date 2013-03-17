window.CigarFinderWeb =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new CigarFinderWeb.Routers.CigarSearchResults()
    Backbone.history.start()

$(document).ready ->
  CigarFinderWeb.initialize()
