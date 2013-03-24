class CigarFinderWeb.Services.LocationLoader
  loadedLocation = null
  locationRequestPerformed = false

  @loadLocation: (onSuccess = ->) =>
    if loadedLocation?
      onSuccess(loadedLocation)
    else
      @once('location:loaded', => onSuccess(loadedLocation))
      locationRequest() unless locationRequestPerformed

  @clearLocation: =>
    loadedLocation = null
    locationRequestPerformed = false

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
