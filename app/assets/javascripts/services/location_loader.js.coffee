class CigarFinderWeb.Services.LocationLoader
  [loadedLocation, geocoder] = []
  locationRequestPerformed = false

  @loadLocation: (query = null, onSuccess = ->) =>
    [onSuccess, query] = [query, null] if typeof query is 'function'

    if query?
      geocodeQuery(query, onSuccess)
    else if loadedLocation?
      onSuccess(loadedLocation)
    else
      @once('location:loaded', => onSuccess(loadedLocation))
      locationRequest() unless locationRequestPerformed

  @clearLocation: =>
    loadedLocation = null
    locationRequestPerformed = false

  geocodeQuery = (query, onSuccess) =>
    geocoder ||= new google.maps.Geocoder()
    geocoder.geocode {address: query}, (resp) ->
      latlng = resp[0].geometry.location
      onSuccess(latitude: latlng.lat(), longitude: latlng.lng())

  locationCallback = (position) =>
    loadedLocation = position.coords
    @trigger('location:loaded')

  fallbackRequest = =>
    $.getJSON 'http://freegeoip.net/json/', (data) =>
      locationCallback(coords: _.pick(data, 'latitude', 'longitude'))

  geolocationRequest = =>
    navigator.geolocation.getCurrentPosition(locationCallback, fallbackRequest, timeout: 5000)

  locationRequest = =>
    if navigator.geolocation?
      geolocationRequest()
    else
      fallbackRequest()
    locationRequestPerformed = true

_.extend(CigarFinderWeb.Services.LocationLoader, Backbone.Events)
