class CigarFinderWeb.Models.CigarStore extends Backbone.Model
  getPosition: ->
    new google.maps.LatLng(@get('latitude'), @get('longitude'))
