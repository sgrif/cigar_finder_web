describe "CigarFinderWeb.Services.LocationLoader", ->
  beforeEach ->
    spyOn(navigator.geolocation, 'getCurrentPosition')
    CigarFinderWeb.Services.LocationLoader.clearLocation()

  describe "fetching user position", ->
    callback = null

    beforeEach ->
      callback = jasmine.createSpy('callback function')

    it "times out after 5 seconds", ->
      CigarFinderWeb.Services.LocationLoader.loadLocation()
      expect(navigator.geolocation.getCurrentPosition).toHaveBeenCalledWith(
        jasmine.any(Function),
        jasmine.any(Function),
        {timeout: 5000}
      )

    describe "when geolocation is supported", ->
      location = coords: { latitude: 1, longitude: -1 }

      beforeEach ->
        navigator.geolocation.getCurrentPosition.andCallFake (success) ->
          success(location)

      it "passes the users coordinates to the callback function", ->
        CigarFinderWeb.Services.LocationLoader.loadLocation(callback)
        expect(callback).toHaveBeenCalledWith(latitude: 1, longitude: -1)

      it "does not geolocate if the location has already been loaded", ->
        CigarFinderWeb.Services.LocationLoader.loadLocation()
        CigarFinderWeb.Services.LocationLoader.loadLocation(callback)
        expect(navigator.geolocation.getCurrentPosition.callCount).toBe(1)
        expect(callback).toHaveBeenCalledWith(location.coords)

      describe "when called multiple times before it finishes loading", ->
        geoCallback = null
        geoLocationLoaded = -> geoCallback(location)

        beforeEach ->
          navigator.geolocation.getCurrentPosition.andCallFake (success) ->
            geoCallback = success

        it 'only geolocates once', ->
          secondCallback = jasmine.createSpy('second callback')
          CigarFinderWeb.Services.LocationLoader.loadLocation()
          CigarFinderWeb.Services.LocationLoader.loadLocation(callback)
          CigarFinderWeb.Services.LocationLoader.loadLocation(secondCallback)
          expect(callback).not.toHaveBeenCalled() # Ensure we've delayed triggering geolocation
          geoLocationLoaded()
          expect(navigator.geolocation.getCurrentPosition.callCount).toBe(1)
          expect(callback).toHaveBeenCalledWith(location.coords)
          expect(secondCallback).toHaveBeenCalledWith(location.coords)

    sharedGeoIpExamples = ->
      location =
        ip: "67.41.101.230", country_code: "US", country_name: "United States",
        region_code: "NM", region_name: "New Mexico", city: "Los Lunas", zipcode: "87031",
        latitude: 34.7744, longitude: -106.7274, metro_code: "790", areacode: "505"
      coords = latitude: 34.7744, longitude: -106.7274

      beforeEach ->
        spyOn($, 'getJSON').andCallFake (url, callback) ->
          callback(location)

      it "performs geolocation by ip address", ->
        CigarFinderWeb.Services.LocationLoader.loadLocation()
        expect($.getJSON).toHaveBeenCalledWith(
          'http://freegeoip.net/json/', jasmine.any(Function))

      it "passes the users coordinates to the callback", ->
        CigarFinderWeb.Services.LocationLoader.loadLocation(callback)
        expect(callback).toHaveBeenCalledWith(coords)

    describe "when geolocation is not supported", ->
      oldNavigator = null

      beforeEach =>
        oldNavigator = window.navigator
        window.navigator = {geolocation: null}

      afterEach =>
        window.navigator = oldNavigator

      sharedGeoIpExamples()

    describe "when geolocation times out", ->
      beforeEach =>
        navigator.geolocation.getCurrentPosition.andCallFake (success, error) ->
          error()
      sharedGeoIpExamples()
