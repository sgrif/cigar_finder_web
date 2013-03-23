class CigarFinderWeb.Models.CigarStore extends Backbone.Model
  getPosition: ->
    new google.maps.LatLng(@get('latitude'), @get('longitude'))

  directionsLink: ->
    directionsQuery = encodePlus("#{@get('name')}, #{@get('address')}")
    "https://maps.google.com/maps?daddr=#{directionsQuery}"
