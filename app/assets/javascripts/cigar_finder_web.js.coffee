window.CigarFinderWeb =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  cigars: []
  initialize: ->
    new CigarFinderWeb.Routers.CigarSearchResults()
    Backbone.history.start(pushState: true)

$(document).ready ->
  CigarFinderWeb.initialize()
