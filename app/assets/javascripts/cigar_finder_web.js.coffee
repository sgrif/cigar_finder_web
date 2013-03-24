window.CigarFinderWeb =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Services: {}
  cigars: []
  initialize: ->
    new CigarFinderWeb.Routers.CigarSearchResults()
    Backbone.history.start(pushState: true)

$(document).ready ->
  CigarFinderWeb.initialize()
